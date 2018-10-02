# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Put your fun stuff here.
JAVA_HOME=/usr/lib/jvm/jdk1.8.0_25/
export JAVA_HOME
export TERM=xterm-256color
export EDITOR=vim

alias weather="curl wttr.in/minsk"
alias mc='. /usr/libexec/mc/mc-wrapper.sh'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export GOPATH=~/work/home/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
