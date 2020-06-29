#!/usr/bin/env python
import re
import os.path as pth
import subprocess
import socket
# https://github.com/pacparser/pacparser
import pacparser
import paramiko

def host_to_port(host):
    '''
    Map an ssh host or a hostname to the port it should use according to
    the pac file.
    '''
    pac_fname = pth.expanduser('~/proxy_urls.pac')
    pacparser.init()
    pacparser.parse_pac(pac_fname)
    proxy_str = pacparser.find_proxy('http://' + host, host)
    match = re.match('SOCKS5 .*:(.*)', proxy_str)
    print('proxy: ' + proxy_str)
    if match:
        return int(match.group(1))
    raise Exception('could not find port in "{}"'.format(proxy_str))

def ssh_host_to_hostname(host):
    config = paramiko.SSHConfig()
    with open(pth.expanduser('~/.ssh/config'), 'r') as f:
        config.parse(f)
    o = config.lookup(host)
    return o['hostname']

def port_used(port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    result = sock.connect_ex(('127.0.0.1', port))
    sock.close()
    return result == 0


def main():
    '''
    Start a persistent (autossh) tunnel to the given host according
    to the port in ~/proxy_urls.pac.

    Warning: Does not work while in tmux on OS X
    (http://stackoverflow.com/questions/29112446/nohup-doesnt-work-with-os-x-yosmite-get-error-cant-detach-from-console-no-s)

    Usage:
        start_tunnel.py new <host>
        start_tunnel.py list
    '''
    import docopt, textwrap
    main_args = docopt.docopt(textwrap.dedent(main.__doc__))

    if main_args['new']:
        host = main_args['<host>']

        try:
            port = host_to_port(host)
            print(host, port)
        except:
            hostname = ssh_host_to_hostname(host)
            port = host_to_port(hostname)
        if port_used(port):
            raise Exception('port in use: {}'.format(port))
        cmd = 'nohup autossh -M 0 -v -D {port} -N {host}'.format(
                    port=port,
                    host=host)
        subprocess.Popen(cmd, shell=True)
    elif main_args['list']:
        subprocess.Popen('ps aux | grep ssh', shell=True)


if __name__ == '__main__':
    main()
