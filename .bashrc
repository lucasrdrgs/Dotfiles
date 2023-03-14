# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
iatest=$(expr index "$-" i)

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [[ $iatest > 0 ]]; then bind "set bell-style visible"; fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

shopt -s histappend
PROMPT_COMMAND='history -a'

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi

EDITOR=vim
VISUAL=vim

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
#export GREP_OPTIONS='--color=auto' #deprecated
alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

alias bd='cd "$OLDPWD"'

# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

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

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias python=python3.10

getBatteryString() {
    pygmentize_exists=$(which acpi)
    if [[ -z "$pygmentize_exists" ]]; then
        echo -n " "
	return
    fi
    batteryPercentage=$(acpi -b | grep -P -o '[0-9]+(?=%)')
    batteryStatus=$(acpi -b | awk '{print $3}')

    if [ "$batteryStatus" = "Charging," ] || [ "$batteryStatus" = "Unknown," ] || [ "$batteryStatus" = "Full," ]; then
        echo -n ""
    else
        echo -n " "
        if [ "$batteryPercentage" -le 10 ]; then
            echo "\[\e[0;38;5;196m\][$batteryPercentage%]"
        elif [ "$batteryPercentage" -le 20 ]; then
            echo "\[\e[0;38;5;202m\][$batteryPercentage%]"
        elif [ "$batteryPercentage" -le 30 ]; then
            echo "\[\e[0;38;5;208m\][$batteryPercentage%]"
        elif [ "$batteryPercentage" -le 50 ]; then
            echo "\[\e[0;38;5;220m\][$batteryPercentage%]"
        elif [ "$batteryPercentage" -le 70 ]; then
            echo "\[\e[0;38;5;149m\][$batteryPercentage%]"
        elif [ "$batteryPercentage" -le 80 ]; then
            echo "\[\e[0;38;5;154m\][$batteryPercentage%]"
        elif [ "$batteryPercentage" -le 90 ]; then
            echo "\[\e[0;38;5;83m\][$batteryPercentage%]"
        elif [ "$batteryPercentage" -le 100 ]; then
            echo "\[\e[0;38;5;46m\][$batteryPercentage%]"
        fi
    fi
    echo -n " "
}

SHH_TOGGLE=1
shh () {
	if [[ $SHH_TOGGLE -eq 0 ]]; then
		SHH_TOGGLE=1
    	PROMPT_COMMAND='PS1="\[\e[38;2;172;212;238m\]\W \[\e[38;2;242;44;61m\]> \[\e[0m\]"'
    	if [ "$TERM_PROGRAM" = "vscode" ]; then
        	PROMPT_COMMAND='PS1="${debian_chroot:+($debian_chroot)}\[\e[38;2;172;212;238m\]\W \[\e[38;2;0;122;204m\]> \[\e[0m\]"'
	    fi
	else
		SHH_TOGGLE=0
		PROMPT_COMMAND='PS1="${debian_chroot:+($debian_chroot)}\[\e[38;2;242;44;61m\]\u$(getBatteryString)\[\e[38;2;172;212;238m\]\w \[\e[38;2;242;44;61m\]> \[\e[0m\]"'
		if [ "$TERM_PROGRAM" = "vscode" ]; then
			PROMPT_COMMAND='PS1="${debian_chroot:+($debian_chroot)}\[\e[38;2;0;122;204m\]code$(getBatteryString)\[\e[38;2;172;212;238m\]\W \[\e[38;2;0;122;204m\]> \[\e[0m\]"'
		fi
	fi
}

shh

LONGCAT=0

cat () {
    pygmentize_exists=$(which pygmentize)
    if [[ -z "$pygmentize_exists" ]]; then
        /bin/cat $1
        echo "(pygmentize not found, fell back to cat)"
        return
    fi

    lxr=""

    if [[ "$#" -eq 2 ]]; then
        lxr="-l $2"
    else
        lxr="-l ${1##*.}"
    fi

    if [[ $LONGCAT -eq 1 ]]; then
        pygmentize -g -O full,style=monokai $lxr $1 | less -NR
    else
        pygmentize -g -O full,style=monokai $lxr $1
    fi
}

longcat () {
    LONGCAT=1
    cat $@
    LONGCAT=0
}

export ANDROID_HOME=$HOME/Android/Sdk
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:/opt/flutter/bin"
