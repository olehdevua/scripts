set -o emacs

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoredups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\n\n\n\[\e[31m\]\u@\h\[\e[39m\] \[\e[32m\]\w\[\e[33m\] \$(parse_git_branch)\[\e[00m\] \[\e[32m\](jobs: \j)\[\e[39m\] \[\e[90m\][\t]\[\e[39m\] \n\[\e[90m\]>\[\e[39m\]\n\[\e[90m\]>\[\e[39m\]  "
#PROMPT_COMMAND='echo -e "\n"'

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

RE () {
    echo "## $1" > ~/.expl_rust.md
    rustc --explain $1 >> ~/.expl_rust.md
}

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
