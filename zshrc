# zshrc
# Armin Briegel

# PATH
export PATH=$PATH:~/bin

# prevent duplicate entries in path
declare -U path

# function to update terminal title bar current working dir
# (borrowed from /etc/bashrc_Apple_Terminal)
update_terminal_cwd() {
	# Identify the directory using a "file:" scheme URL, including
	# the host name to disambiguate local vs. remote paths.
	
	# Percent-encode the pathname.
	local url_path=''
	{
	    # Use LC_CTYPE=C to process text byte-by-byte. Ensure that
	    # LC_ALL isn't set, so it doesn't interfere.
	    local i ch hexch LC_CTYPE=C LC_ALL=
	    for (( i = 1; i <= ${#PWD}; ++i)); do
            ch="$PWD[i]"
            if [[ "$ch" =~ [/._~A-Za-z0-9-] ]]; then
                url_path+="$ch"
            else
                printf -v hexch "%02X" "'$ch"
                # printf treats values greater than 127 as
                # negative and pads with "FF", so truncate.
                url_path+="%${hexch: -2:2}"
            fi
	    done
	}
	printf '\e]7;%s\a' "file://$HOSTNAME$url_path"
}

# this updates just the window title
update_terminal_window_title() { printf "\e]0;$@\a" }

# add a function to update window title cwd on dir change
chpwd_functions=(update_terminal_cwd)


# PROMPT

# %(?.√.?%?)  :  if return code `?` is 0, show `√`, else show `?%?`
# %1~         :  current working dir, shortening home to `~`, show the last `1` element
# %#          :  `#` if root, `%` otherwise
# %B %b       :  start/stop bold
PROMPT='%(?.%F{green}√.%F{red}?%?)%F %B%1~%b %# '


# case insensitive globbing
setopt NO_CASE_GLOB
# enable extended globbing features
setopt EXTENDED_GLOB
# sort extensions with numbers numerically
setopt NUMERIC_GLOB_SORT

# case insensitive path-completion

autoload -U compinit && compinit
# from: https://stackoverflow.com/a/24237590
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# HISTORY
   
# history file
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
# include more information (timestamp)
setopt EXTENDED_HISTORY
# multiple shells append
setopt APPEND_HISTORY
#ignore dupes when searching
setopt HIST_FIND_NO_DUPS
# expire dupes first
setopt HIST_EXPIRE_DUPS_FIRST 
# makes history substitution commands a bit nicer. I don't fully understand
setopt HIST_VERIFY
# shares history across multiple zsh sessions, in real time
setopt SHARE_HISTORY
# don't store dupes
setopt HIST_IGNORE_DUPS
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
setopt HIST_REDUCE_BLANKS


## Auto Correction

setopt CORRECT
setopt CORRECT_ALL

# print a message on SSH connection:
if [[ -n "$SSH_CLIENT" ]]; then
	# ssh connection, print hostname and os version
	echo "Welcome to $(scutil --get ComputerName) ($(sw_vers -productVersion))"
fi


# set EDITOR to bbedit
if [[ -x "/usr/local/bin/bbedit" ]]; then
    export EDITOR="/usr/local/bin/bbedit -w --resume"
fi


# ALIASES

alias -g ll="ls -l"

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
alias -g badge="tput bel"

alias -g reveal="open -R"

alias -g pacifist='open -a "Pacifist"'
alias -g spackage='open -a "Suspicious Package"'


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

