# zshrc
# Armin Briegel

# set a profile version
ZSHRC_VERSION="1"

# prevent duplicate entries in path
declare -U path

# PATH
path+=~/bin

# include my zshfunctions dir in fpath:
my_zsh_functions=~/Projects/dotfiles/zshfunctions/
if [[ -d $my_zsh_functions ]]; then
    fpath=( ~/Projects/dotfiles/zshfunctions $fpath )
fi


# PROMPT

# this sets up the connection with the Apple Terminal Title Bar
autoload -U update_terminal_pwd && update_terminal_pwd

# Actual Prompt

# %(?.√.?%?)  :  if return code `?` is 0, show `√`, else show `?%?`
# %1~         :  current working dir, shortening home to `~`, show the last `1` element
# %#          :  `#` if root, `%` otherwise
# %B %b       :  start/stop bold
# %F{...}     :  colors
PROMPT='%(?.%F{green}√.%F{red}?%?)%F %B%1~%b %# '


# SHELL OPTIONS

# enable extended globbing features
setopt EXTENDED_GLOB
# case insensitive globbing
setopt NO_CASE_GLOB
# sort extensions with numbers numerically
setopt NUMERIC_GLOB_SORT

# Enable Auto cd
setopt AUTO_CD

# HISTORY
   
# history file
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
# store more information (timestamp)
#setopt EXTENDED_HISTORY

# shares history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY

# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST 
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS

# when using history substitution (!!, !$, etc.), present for confirmation/editing
setopt HIST_VERIFY

## Correction
setopt CORRECT
setopt CORRECT_ALL

# KEY BINDINGS

bindkey $'^[[A' up-line-or-search    # up arrow
bindkey $'^[[B' down-line-or-search  # down arrow

# COMPLETION

# add my completion folder to fpath

mac_completion_dir=~/Projects/mac-zsh-completions/completions/
if [[ -d $mac_completion_dir ]]; then
    fpath=( $mac_completion_dir $fpath )
fi

# case insensitive path-completion

zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# show descriptions when autocompleting
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' format 'Completing %d'

# partial completion suggestions
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' expand prefix suffix

# list with colors
zstyle ':completion:*' list-colors ''x

# load completion
autoload -Uz compinit && compinit

# load bashcompinit for some old bash completions
autoload bashcompinit && bashcompinit

# autopkg completion
[[ -r ~/Projects/autopkg_complete/autopkg ]] && source ~/Projects/autopkg_complete/autopkg

# enable arrow key menu for completion
#zstyle ':completion:*' menu select

# print a message on SSH connection:
if [[ -n "$SSH_CLIENT" ]]; then
	# ssh connection, print hostname and os version
	echo "Welcome to $(scutil --get ComputerName) ($(sw_vers -productVersion))"
fi


# ALIASES

alias ll="ls -l"

alias reveal="open -R"

alias pacifist='open -a "Pacifist"'

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
alias -g badge="tput bel"


# FUNCTIONS

# prints path to frontmost finder window
autoload pwdf && pwdf

# vnc opens screen sharing
autoload vnc

# man page functions
autoload xmanpage
alias xman=xmanpage
alias man=xmanpage

# editor functions

# set EDITOR to bbedit
if [[ -x "/usr/local/bin/bbedit" ]]; then
    export EDITOR="/usr/local/bin/bbedit -w --resume"
fi

# show plutil -lint results in bbedit
function  pllint () {
	plutil -lint "$*" | bbresults -p '(?P<file>.+?):(?P<msg>.*\sline\s(?P<line>\d+)\s.*)$'
}

# show shellcheck results in bbedit
function bbshellcheck {
    shellcheck -f gcc "$@" | bbresults
}

