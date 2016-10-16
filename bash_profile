#path
PATH=${PATH}:~/bin
PATH=${PATH}:~/Dropbox/bin

# make globbing case-insensitive
shopt -s nocaseglob

# make history file BIG
export HISTSIZE=10000
export HISTFILESIZE=10000

# avoid history duplicates
export HISTCONTROL=ignoredups:erasedups

# share history
shopt -s histappend
export PROMPT_COMMAND="history -a; history -r; $PROMPT_COMMAND"

# add timestamp to history
export HISTTIMEFORMAT="%F %T "

# ls color
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# set EDITOR to bbedit
if [[ -e "/usr/local/bin/bbedit" ]]
then
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

# FUNCTIONS

function quit() {
	for app in $*; do
		osascript -e 'quit app "'$app'"'
	done
}

function relaunch {
	for app in $*; do
		osascript -e 'quit app "'$app'"'
		sleep 5
		open -a $app
	done
}

function preman() { man -t "$@" | open -f -a "Preview" ;}

function bbman () {
  MANWIDTH=80 MANPAGER='col -bx' man $@ | bbedit --clean --view-top -t "man $@"
}

#function ssh-copy-id() {
#    cat ~/.ssh/id_rsa.pub | ssh "$1" "cat >> ~/.ssh/authorized_keys"
#}

function recipe-open() { open "$(autopkg info '$1' | grep 'Recipe file path' | cut -c 22-)"; }
function recipe-edit() { bbedit "$(autopkg info '$1' | grep 'Recipe file path' | cut -c 22-)"; }
function recipe-reveal() { reveal "$(autopkg info '$1' | grep 'Recipe file path' | cut -c 22-)"; }

alias pacifist='open -a "Pacifist"'
alias spackage='open -a "Suspicious Package"'

