# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

uname -a | grep Ubuntu > /dev/null
IS_UBUNTU=$?

# this didn't seem to run sometimes... watch for recursion
if [ -z "$RAN_PROFILE_FROM_BASHRC" ]; then
    export RAN_PROFILE_FROM_BASHRC=1
    source ./.profile
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alhFU'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias less='less --LINE-NUMBERS -R'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias matlab="matlab -nodisplay -nosplash"
alias matlab2013="matlab2013 -nodisplay -nosplash"
alias matlab2014="matlab2014 -nodisplay -nosplash"

alias py="python"
alias ipy="ipython"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# chrome default browser
if [ -n "$DISPLAY" ]; then
     export BROWSER=google-chrome
fi


source /home/cogswell/torch/install/bin/torch-activate
# use this version of cogswell_libs until changes to the tasks framework are stabalized
#export PYTHONPATH="$PYTHONPATH:/home/cogswell/projects/tree_nets/cogswell_libs/python/:/srv/share/data/mscoco/tools/"
#export PYTHONPATH="$PYTHONPATH:/home/cogswell/build/cogswell_libs/python/:/srv/share/data/mscoco/tools/:lib/:/srv/share/gpu_lock/"
export PYTHONPATH="$PYTHONPATH:/srv/share/data/mscoco/tools/:lib/"
#export SAGE_PATH="$PYTHONPATH$"
export PATH="/home/cogswell/usr/bin/:$PATH:/home/cogswell/.local/bin:/usr/local/cuda/bin:/home/cogswell/build/pylearn2/pylearn2/scripts:/srv/share/gpu_lock/"
export PATH="$PATH:/home/cogswell/.gem/ruby/2.2.0/bin:/home/cogswell/.gem/ruby/1.8/bin"
# link to cuDNN
#export LD_LIBRARY_PATH="/usr/lib64/mpich/lib/:/usr/local/cuda-7.0/lib64/:/home/cogswell/usr/lib/cudnn_v3/:/home/cogswell/usr/lib/:$LD_LIBRARY_PATH"
# 5/12/16
#export LD_LIBRARY_PATH="/home/cogswell/Downloads/cudnn_v4/cuda/lib64/:/usr/lib64/mpich/lib/:/usr/local/cuda-7.0/lib64/:/home/cogswell/usr/lib/cudnn_v3/:/home/cogswell/usr/lib/:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/home/cogswell/Downloads/cudnn_v4/cuda/lib64/:/usr/lib64/mpich/lib/:/usr/local/cuda-7.5/lib64/:/home/cogswell/usr/lib/cudnn_v3/:/home/cogswell/usr/lib/:$LD_LIBRARY_PATH"

# add caffe things
#export CAFFE_ROOT="/srv/share/caffe_gpu"
#export CAFFE_ROOT="/home/cogswell/projects/tree_nets/caffe"
#export CAFFE_ROOT="/home/cogswell/projects/decornets/caffe"
export CAFFE_ROOT="./caffe"
export PYTHONPATH="$PYTHONPATH:$CAFFE_ROOT/python/"
export PATH="$PATH:$CAFFE_ROOT/build/tools/:$CAFFE_ROOT/build/examples/"

export JAVA_HOME="/home/cogswell/Downloads/jdk1.8.0_77"
export PATH="$JAVA_HOME/bin:$PATH:/home/cogswell/Downloads/apache-maven-3.3.9/bin"
export CLASSPATH="/home/cogswell/Downloads/simplenlg-v4.4.3/simplenlg-v4.4.3.jar"

# jut so screen will work on godel
export TERM="rxvt-unicode"

# always use the python2.7 virtualenv with all the goodies
#if [ `hostname` == "rosenblatt.ece.vt.edu" ]
#then
#  #source /home/cogswell/cog_venv/bin/activate
#  source /share/cog_venv/bin/activate
#  #echo "re-enable this venv after finishing multiproc project (12/4/14)... also uncomment PYTHON_PATH, SAGE_PATH, PATH"
#  #source /home/cogswell/minsky_venv/bin/activate
#elif [ `hostname` == "minsky.ece.vt.edu" ] || \
#     [ `hostname` == "vapnik" ]
#then
#  #source $HOME/.virtualenv/bin/activate
#  source /home/cogswell/minsky_venv/bin/activate
#elif [ `hostname` == "tesla.ece.vt.edu" ]
#then
#  source /share/tes_venv/bin/activate
#elif [ `hostname` == "mccarthy.ece.vt.edu" ]
#then
#  source /share/mc_venv/bin/activate
#else
#  # required for my local python install
#  #export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/cogswell/usr/lib/"
#  source /home/cogswell/local_venv/bin/activate
#fi
export PS1=""
export WORKON_HOME=~/envs
if [ $IS_UBUNTU == 0 ]; then
    # python2.7
    source $WORKON_HOME/ub_env/bin/activate
    # python3.4
    #source $WORKON_HOME/ub_env3/bin/activate
    source /usr/local/bin/virtualenvwrapper.sh
else
    source $WORKON_HOME/base_venv/bin/activate
    source $WORKON_HOME/base_venv/bin/virtualenvwrapper.sh
fi

export PROMPT_DIRTRIM=2
# is stdout a terminal?
if [ -t 1 ]; then
    # if so, use color, as long as it's available
    ncolors=$(tput colors)
    if (( $ncolors > 0 )); then
        color_prompt=yes

        reset=$(tput sgr0)

        # Solarized colors
        # (https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized#the-values)
        black=$(tput setaf 0)
        blue=$(tput setaf 33)
        cyan=$(tput setaf 37)
        green=$(tput setaf 64)
        orange=$(tput setaf 166)
        purple=$(tput setaf 125)
        red=$(tput setaf 124)
        white=$(tput setaf 15)
        yellow=$(tput setaf 136)
    else
        color_prompt=
    fi
fi

source ~/.git-prompt.sh
if [ "$color_prompt" = yes ]; then
    PS1="\[$purple\]$PS1\[$blue\]\u\[$reset\]@\h:\[$orange\]\w\[$green\]\$(__git_ps1)\[$reset\]\$ "
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1="\u@\h:\w$(__git_ps1)\$ "
fi
unset color_prompt force_color_prompt


# pudb config location
export XDG_CONFIG_HOME="/home/cogswell/.xdg_config"

# enable up to date dev tools
# WARNING: enabling this causes recursive execution of .bashrc (? I think)... try surrounding with a check to see if it's enabled.
#scl enable devtoolset-2 bash
# this is an alternative to the above which will not infinitely recurse terminals
#source /opt/rh/devtoolset-2/enable

