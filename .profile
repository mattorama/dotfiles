#!/usr/bin/env bash

# ENVIRONMENTAL VARIABLES

# colors in terminal
export CLICOLOR=1
export LSCOLORS=gxFxCxDxBxegedabagacad

## project shortcuts
export DEV=${HOME}/Projects

# added for C compiler
export PATH=/usr/local/clang6/bin:$PATH

# added for java
export JAVA_HOME="`/usr/libexec/java_home -v 1.8`"

# added for libpq
export PATH="/usr/local/opt/libpq/bin:$PATH"


# ALIASES

alias ..='cd ..'
alias ...='cd ../..'

# brew
alias brewup='brew update && brew upgrade && brew cleanup && brew linkapps'

## command line sublime text
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

## git 
alias gprum='git pull --rebase upstream master'
alias gpom='git push origin master'
alias gpru='git pull --rebase upstream $BRANCH'
alias gpo='git push origin $BRANCH'

## server access
alias sa1='ssh -p 3389 user@host'

## database access
alias db1='psql -h hostname -d db'

## project shortcuts
alias dev='cd "${DEV}"'
alias rep='cd "${REPHOME}"; subl .'

# added for anaconda
ln -s ${HOME}/anaconda3/bin/conda /usr/local/bin/conda
ln -s ${HOME}/anaconda3/bin/jupyter /usr/local/bin/jupyter
ln -s ${HOME}/anaconda3/bin/jupyter-lab /usr/local/bin/jupyter-lab
ln -s ${HOME}/anaconda3/bin/activate /usr/local/bin/activate
ln -s ${HOME}/anaconda3/bin/deactivate /usr/local/bin/deactivate


# FUNCTIONS

# most used commands
alias most_used='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 10'

# known hosts autocomplete
complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g -e s/"\["//g -e s/"\]".*//g | uniq`;)" ssh

# Notify by email and/or SMS when shell command completes
# Usage:
#    $ some_command ; notify
# After the command finishes, email is sent to blankspace-delimited list of email addresses in mail variable
# Especially useful if you use a mobile carrier address that sends you a text message
# For example, nnnnnnnnnn@messaging.sprintpcs.com for Sprint, nnnnnnnnnn@vtext.com for Verizon
#     or nnnnnnnnnn@txt.att.net for AT&T
function notify() {
    # NOTE!!! Set mail var to desired list of email addresses.
    mail="${NOTIFY_EMAIL}"
    str1="`history 1 | cut -b 8-`"
    str2="${str1%;*}"
    echo ${str2} | mail -s CMD_FINISH ${mail}
}

# git autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# get current branch in git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo "[${BRANCH}${STAT}]"
    else
        echo ""
    fi
}

# terminal prompt
export PS1="\W\`parse_git_branch\`\\$ "