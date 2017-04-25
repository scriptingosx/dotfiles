# echo bash_profile $(whoami)

#path
PATH=${PATH}:~/bin
#PATH=${PATH}:~/Dropbox/bin
export PATH

#prompt

# default macOS prompt is: \h:\W \u\$
# only change for local access
if [ -z "$SSH_CLIENT" ]; then
	export PS1="\[\e[1;30m\]\W\[\e[m\] \\$ "
fi

# make globbing case-insensitive
shopt -s nocaseglob

# make history file BIG
export HISTSIZE=50000
export HISTFILESIZE=50000

# avoid history duplicates
#export HISTCONTROL=ignoredups:erasedups

# share history
#shopt -s histappend
#export PROMPT_COMMAND="history -a; history -r; $PROMPT_COMMAND"

# add timestamp to history
#export HISTTIMEFORMAT="%F %T "

# color
export CLICOLOR=1
#export LSCOLORS=ExFxBxDxCxegedabagacad

# set EDITOR to bbedit
if [[ -e "/usr/local/bin/bbedit" ]]; then
    export EDITOR="bbedit -w --resume"
fi

# ALIASES

alias ll="ls -l"

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
alias badge="tput bel"

# Sets a mark in the terminal
alias mark="osascript -e 'if app \"Terminal\" is frontmost then tell app \"System Events\" to keystroke \"u\" using command down'"
alias bookmark="osascript -e 'if app \"Terminal\" is frontmost then tell app \"System Events\" to keystroke \"M\" using command down'"

alias ..="cd .."
alias ...="cd ../.."
alias cd..="cd .."

alias reveal="open -R"

alias pacifist='open -a "Pacifist"'
alias spackage='open -a "Suspicious Package"'


# FUNCTIONS

function quit() {
	for app in $*; do
		osascript -e 'quit app "'$app'"'
	done
}

# man page functions

function preman() { man -t "$@" | open -f -a "Preview" ;}
function xmanpage() { open x-man-page://$@ ; }
alias xman=xmanpage

function bbman () {
  MANWIDTH=80 MANPAGER='col -bx' man $@ | bbedit --clean --view-top -t "man $@"
}

# editor functions

function  pllint () {
	plutil -lint $@ | bbresults -p '(?P<file>.+?):(?P<msg>.*\sline\s(?P<line>\d+)\s.*)$'
}

# prints the path of the front Finder window. Desktop if no window open
function pwdf () {
	osascript <<EOS
		tell application "Finder"
			if (count of Finder windows) is 0 then
				set dir to (desktop as alias)
			else
				set dir to ((target of Finder window 1) as alias)
			end if
			return POSIX path of dir
		end tell
EOS
}

# changes directory to frontmost 
alias cdf='pwdf; cd "$(pwdf)"'

# Sierra added ssh-copy-id
#function ssh-copy-id() {
#    cat ~/.ssh/id_rsa.pub | ssh "$1" "cat >> ~/.ssh/authorized_keys"
#}

# autopkg recipe functions

function recipe-open() { open "$(autopkg info '$1' | grep 'Recipe file path' | cut -c 22-)"; }
function recipe-edit() { bbedit "$(autopkg info '$1' | grep 'Recipe file path' | cut -c 22-)"; }
function recipe-reveal() { reveal "$(autopkg info '$1' | grep 'Recipe file path' | cut -c 22-)"; }

