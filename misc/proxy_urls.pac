function FindProxyForURL(url, host)
{
    var url = url.toLowerCase(),
        host = host.toLowerCase(),
        // All but the last entries are either a `Host` name from ssh config
        // or a `hostname` (as in the hostname command). The last entry
        // is automatically filled in.
        site_list = [
            ['example_hostname']
        ],
        base_port = 8080;
    // map each host to a unique port number starting at 8080
    for (var index = 0; index < site_list.length; index++) {
        site_list[index].push("SOCKS5 127.0.0.1:" + (base_port + index));
        for (var hindex = 0; hindex < site_list[index].length-1; hindex++) {
            if (host == site_list[index][hindex] ||
                shExpMatch(host, "*." + site_list[index][hindex])) {
                return site_list[index][site_list[index].length-1];
            }
        }
    }

    // urls that match these regular expressions get mapped to these ports
    var exp_list = [];
    for(var index = 0;index<exp_list.length;index++){
        var re = new RegExp(exp_list[index]);
        if(url.match(re)){
            return "SOCKS5 127.0.0.1:8080";
        }
    }

    return "DIRECT";
}
