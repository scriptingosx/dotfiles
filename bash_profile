# bash_profile
# Armin Briegel

# PATH
export PATH=${PATH}:~/bin

# print a message on SSH connection:
if [[ -n "$SSH_CLIENT" ]]; then
	# ssh connection, print hostname and os version
	echo "Welcome to $(scutil --get ComputerName) ($(sw_vers -productVersion))"
fi

# PROMPT

# default macOS prompt is: \h:\W \u\$

# assemble the prompt string PS1
# inspired from: https://stackoverflow.com/a/16715681
function __build_prompt {
    local EXIT="$?" # store current exit code
    
    # define some colors
    local RESET='\[\e[0m\]'
    local RED='\[\e[0;31m\]'
    local GREEN='\[\e[0;32m\]'
    local BOLD_GRAY='\[\e[1;30m\]'
    # longer list of codes here: https://unix.stackexchange.com/a/124408
    
    # start with an empty PS1
    PS1=""

    if [[ $EXIT -eq 0 ]]; then
        PS1+="${GREEN}√${RESET} "      # Add green for success
    else
        PS1+="${RED}?️️️${EXIT}${RESET} " # Add red if exit code non 0
    fi
    # this is the default prompt for 
    PS1+="${BOLD_GRAY}\W ${RESET}\$ "
}

# set the prompt command
# include previous values to maintain Apple Terminal support (window title path and sessions)
# this is explained in /etc/bashrc_Apple_Terminal
PROMPT_COMMAND="__build_prompt${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

# make globbing case-insensitive
shopt -s nocaseglob

# make history file BIG
export HISTSIZE=50000
export HISTFILESIZE=50000

# color
export CLICOLOR=1

# set EDITOR to bbedit
if [[ -e "/usr/local/bin/bbedit" ]]; then
    export EDITOR="bbedit -w --resume"
fi

# ALIASES

alias ll="ls -l"

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
alias badge="tput bel"

alias ..="cd .."
alias ...="cd ../.."
alias cd..="cd .."

alias reveal="open -R"

alias pacifist='open -a "Pacifist"'
alias spackage='open -a "Suspicious Package"'

# FUNCTIONS

function vnc() {
	open vnc://"$USER"@"$1"
}

# man page functions

function xmanpage() { open x-man-page://"$*" ; }
alias xman=xmanpage
alias man=xmanpage

# editor functions
function  pllint () {
	plutil -lint "$*" | bbresults -p '(?P<file>.+?):(?P<msg>.*\sline\s(?P<line>\d+)\s.*)$'
}

function bbshellcheck {
    shellcheck -f gcc "$@" | bbresults
}
