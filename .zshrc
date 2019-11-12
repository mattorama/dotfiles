#!/usr/bin/env zsh

# enable the default zsh completions!
autoload -Uz compinit && compinit

# command prompt
export PROMPT="%~ $ "

# colors in terminal
export CLICOLOR=1
export LSCOLORS=gxFxCxDxBxegedabagacad

# PATHS

export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# access to conda commands without ruining system python
if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]
then
    source "$HOME/anaconda3/etc/profile.d/conda.sh"
else
    export PATH="$HOME/anaconda3/bin:$PATH"
fi

# git autocomplete
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

# ALIASES

alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -al'

# brew
alias brewup='brew update && brew upgrade && brew cleanup && brew linkapps'

## database access
alias db1=\
'psql -h plastiq.periscopewarehouse.com -d site_14042 -p 5439 -U plastiq'

# docker
alias dpsa="docker ps -a"
alias dcup="docker-compose up"
alias dcupd="docker-compose up -d"

# git
alias gprum='git pull --rebase upstream master'
alias gpom='git push origin master'
alias gpru='git pull --rebase upstream $BRANCH'
alias gpo='git push origin $BRANCH'

# utils
alias most_used=\
'cut -f1 -d" " ~/.zsh_history | sort | uniq -c | sort -nr | head -n 10'

# PROJECT SHORTCUTS

export DEVHOME=${HOME}/Projects
alias dev='cd "${DEVHOME}"'
export DOTHOME=${DEVHOME}/dotfiles
alias dot='cd "${DOTHOME}"; subl .'
export PLIHOME=${DEVHOME}/pliancy
alias pli='cd "${PLIHOME}"; subl .'
export TUTHOME=${DEVHOME}/tutv
alias tut='cd "${TUTHOME}"; subl .'
export LEAHOME=${DEVHOME}/leads
alias lea='cd "${LEAHOME}"; subl .'

# FUNCTIONS

# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$_";
}
