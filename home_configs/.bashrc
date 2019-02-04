# .bashrc
# Nathan Parker's .bashrc

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
  . /etc/bash.bashrc
fi

# Set my path.  The rest was set in ~/.profile.
export PATH=$PATH:$HOME/bin:$HOME/git/depot_tools

# I've got fancy tab completion turned off by default with
# ~/.no_bash_completion, but I do want a few simple ones:
complete -d cd

# Turn it on for g4d... Need to find a better way.
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion;
fi


shopt -s histappend histreedit histverify
export HISTCONTROL='ignoredups:ignorespace'
export HISTFILESIZE=100000
export HISTIGNORE='ls:lst:[bf]g:exit'
export HISTSIZE=1000
export HISTTIMEFORMAT="%a %H:%M:%S  "

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Editor
export EDITOR=vim
alias vi=vim


### Chrome Dev
# Build chromium instead
export GYP_DEFINES='use_goma=1 component=shared_library'
unset CHROME_BUILD_TYPE
export CHROME_BUILD_TYPE

# User specific aliases and functions go here (override system defaults)
alias ls='ls -F --color=auto'  # List files with symbols (/ * @) and colors
alias l='ls -lF'               # List files with symbols
alias mv='mv -i'               # Interactive confirmation before move
alias rm='rm -i'               # Interactive confirmation before delete
alias cp='cp -ip'              # Interactive confirm. before copy; preserve timestamp
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias md='mkdir'
alias ps_all='/bin/ps -o pid,user,pcpu,ppid,rss,stat,start_time,bsdtime,command -w -w --sort=start_time,pid -e'
function lst { echo "..."; ls -tlr "$@" |tail; }
function po {
  echo "  PID USER     %CPU  PPID   RSS STAT START   TIME COMMAND"
  ps_all | egrep -v 'grep .*-iii' | grep -iii "$1"
}
alias ..='cd ..'
alias hi='history | tail -100'

# Quick links.  For absolute paths I want to remember.
function q { cd -P ~/q/$1 ; }

# Useful for naming files
alias d="date '+%Y-%m-%d_%H%M%S'"

# More reasonable calculator
alias dc='dc -e 15k -'

# File pager
export LESS='-C -i -M -x8 -y10 -R'
export PAGER=less
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"


# I like color
export GREP_COLOR=1

alias delete='/bin/rm'         # I really mean it

############################################
# If not running interactively, stop now
if [ -z "$PS1" ]; then
  return
fi

# Running under screen? Remove $DISPLAY.
if [[ "$TERM" = "screen" ]] ; then
  # Fix so screen shows last command with CTRLa "
  #trap '[[ "_$BASH_COMMAND" = "_$PROMPT_COMMAND" ]] || echo -ne "\x1bk${BASH_COMMAND}\x1b\\"' DEBUG
  unset DISPLAY
fi

# PROMPTS:

unset PROMPT_DIRTRIM
# Color trap: Turn text back to white after typing a command.
# This may have side effects, so we turn it off asap.
function setcolortrap {
  shopt -s extdebug
}
trap "printf '\e[0m'; shopt -u extdebug" DEBUG



# Basic two-line prompt w/ color.
#export PS1="${debian_chroot:+($debian_chroot)}\e[0;1m\h[\!]:\w\e[0m\n\$ "

# Funky two line prompt
#export PS1="\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h'; else echo '\[\033[0;33m\]\u\[\033[0;37m\]@\[\033[0;96m\]\h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]"

# Two-line prompt w/ yellow command, and fancy CiTC-aware cwd
#export PS1="${debian_chroot:+($debian_chroot)}\e[0;1m\h[\!]:\w\e[0m\e[1;33m\n\$ "
# Two-line prompt w/ yellow command, and fancy CiTC-aware cwd
#PS1="${debian_chroot:+($debian_chroot)}\e[0;1m\h[\!]:\$PWD\e[0m\e[1;33m\n\$ \$(setcolortrap)"

# Same as above, with git-branch awareness as well. This is slow.
GIT_PS1_SHOWDIRTYSTATE=1
#GIT_PS1_SHOWUNTRACKEDFILES=1
#GIT_PS1_SHOWCOLORHINTS=1
PS1="${debian_chroot:+($debian_chroot)}\e[0;1m\h[\!]:\$PWD\e[0m\e[1;33m\n\$ \$(setcolortrap)"

