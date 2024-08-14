# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
iatest=$(expr index "$-" i)

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [[ $iatest > 0 ]]; then bind "set bell-style visible"; fi

export EDITOR=vim
export VISUAL=vim

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
# if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi

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

get_venv_name () {
    if [[ "$VIRTUAL_ENV" ]]; then
        VENV_NAME=$(basename "$VIRTUAL_ENV")
        echo "($VENV_NAME) "
    fi
}

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

stringify_git_branch() {
	branch=""

	git_branch="$(parse_git_branch)"

	if [[ -n $git_branch ]]; then
		branch=" \[\e[38;5;194m\][$git_branch]\[\e[0m\]"
	fi
	
	echo "$branch"
}

SHH_TOGGLE=1
shh () {
	if [[ $SHH_TOGGLE -eq 0 ]]; then
		SHH_TOGGLE=1
    	PROMPT_COMMAND='PS1="$(get_venv_name)\[\e[38;2;172;212;238m\]\W$(stringify_git_branch) \[\e[38;2;242;44;61m\]> \[\e[0m\]"'
    	if [ "$TERM_PROGRAM" = "vscode" ]; then
        	PROMPT_COMMAND='PS1="$(get_venv_name)\[\e[38;2;172;212;238m\]\W$(stringify_git_branch) \[\e[38;2;0;122;204m\]> \[\e[0m\]"'
	    fi
	else
		SHH_TOGGLE=0
		PROMPT_COMMAND='PS1="$(get_venv_name)\[\e[38;2;242;44;61m\]\u \[\e[38;2;172;212;238m\]\w$(stringify_git_branch) \[\e[38;2;242;44;61m\]> \[\e[0m\]"'
		if [ "$TERM_PROGRAM" = "vscode" ]; then
			PROMPT_COMMAND='PS1="$(get_venv_name)\[\e[38;2;0;122;204m\]code \[\e[38;2;172;212;238m\]\W$(stringify_git_branch) \[\e[38;2;0;122;204m\]> \[\e[0m\]"'
		fi
	fi
}

shh

LONGCAT=0

alias ccat="/usr/bin/cat"
alias catt="/usr/bin/cat"
alias caat="/usr/bin/cat"

cat () {
    wezterm_exists=$(which wezterm 2>/dev/null)
    if [[ $# -ge 1 && -n "$wezterm_exists" ]]; then
        mime=$(file -b --mime-type $1)
        if [[ "$mime" == *image/* ]]; then
            wezterm imgcat "$@"
            return 0
        fi
    fi

    pygmentize_exists=$(which pygmentize 2>/dev/null)
    if [[ -z "$pygmentize_exists" ]]; then
        if [[ $LONGCAT -eq 1 ]]; then
            /bin/cat $@ | less -NR
        else
            /bin/cat $@
        fi
        echo "(pygmentize not found, fell back to cat)"
        return
    fi

    if [[ $LONGCAT -eq 1 ]]; then
        pygmentize -g -O full,style=monokai $1 | less -NR
    else
        pygmentize -g -O full,style=monokai $1
    fi
}

longcat () {
    LONGCAT=1
    cat $@
    LONGCAT=0
}

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

#export ANDROID_HOME=$HOME/Android/Sdk
#export PATH="$PATH:$ANDROID_HOME/emulator"
#export PATH="$PATH:$ANDROID_HOME/platform-tools"
#export PATH="$PATH:/opt/flutter/bin"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

alias mkvenv="if [ ! -d \"./venv\" ]; then python -m venv venv; fi; source venv/bin/activate"

alias ac="source venv/bin/activate"
alias py="python"
function py {
	if [ $# -eq 0 ]; then
		python
	else
		python $@
	fi
}
alias pym="py main.py"
function cf {
	cf_target='.'
	if [ $# -ne 0 ]; then
		cf_target="$1"
	fi
	echo $(ls -1 $cf_target | wc -l)
}

function lenv {
	env_file=".env"
	if [ $# -ne 0 ]; then
		env_file="$1"
	fi
	set -o allexport && source $env_file && set +o allexport
}

export PATH="$PATH:$(go env GOPATH)/bin"
