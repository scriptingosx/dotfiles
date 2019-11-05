# zshrc
# Armin Briegel

# set a profile version
ZSHRC_VERSION="2019-11-04"

# path to directory containing repositories
repo_dir=~/Projects

# path to my zsh functions folder:
my_zsh_functions=$repo_dir/dotfiles/zshfunctions/

# path to mac completions dir
mac_completion_dir=$repo_dir/mac-zsh-completions/completions/



# prevent duplicate entries in path
declare -U path

# PATH
path+=~/bin


# include my zshfunctions dir in fpath:
if [[ -d $my_zsh_functions ]]; then
    fpath=( $my_zsh_functions $fpath )
fi


# PROMPT

# only for Mojave and earlier
if [[ $(sw_vers -buildVersion) < "19" ]]; then 
    # this sets up the connection with the Apple Terminal Title Bar
    autoload -U update_terminal_pwd && update_terminal_pwd
fi

# Actual Prompt

# %(?.√.?%?)  :  if return code `?` is 0, show `√`, else show `?%?`
# %?          :  exit code of previous command
# %1~         :  current working dir, shortening home to `~`, show the last `1` element
# %#          :  `#` if root, `%` otherwise
# %B %b       :  start/stop bold
# %F{...}     :  colors, see https://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
# %f          :  reset to default color
# %(!.        :  conditional depending on privileged user
PROMPT='%(?..%F{red}?%? )%B%F{240}%1~%b%f %(!.#.%(?.%F{green}.%F{red})➜%f) '


# Git status
autoload -U git_vcs_setup && git_vcs_setup

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
#setopt APPEND_HISTORY

# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST 
# do not store duplications, keep newest
setopt HIST_IGNORE_ALL_DUPS
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
#autoload bashcompinit && bashcompinit

# autopkg completion
#[[ -r $repo_dir/autopkg_complete/autopkg ]] && source $repo_dir/autopkg_complete/autopkg

# enable arrow key menu for completion
#zstyle ':completion:*' menu select

# print a message on SSH connection:
if [[ -n "$SSH_CLIENT" ]]; then
	# ssh connection, print hostname and os version
	echo "Welcome to $(scutil --get ComputerName) ($(sw_vers -productVersion))"
fi


# ALIASES

alias ll="ls -lG"

alias reveal="open -R"

alias pacifist='open -a "Pacifist"'

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
alias -g badge="tput bel"

# Suffix Aliases

alias -s txt=bbedit
alias -s log="open -a Console"
alias -s pkg=pacifist
alias -s plist=pledit

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


## some plug-ins

# zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
[[ -f $repo_dir/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source $repo_dir/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_STRATEGY=( completion history )

# zsh-syntax-highlighting
# (note, according to their docs, this must be loaded _LAST_)
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
[[ -f $repo_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source $repo_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# always return true
true
