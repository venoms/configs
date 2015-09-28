#for whatever reason my mac needs this
export SHELL=$(which bash)

#prevent locking with C-Q C-S
stty -ixon -ixoff

alias ls='ls --color=auto'
alias branch='urxvt -cd "$(pwd)" &'

function lspw {
	if [[ $(ps aux | grep kpcli | wc -l) -gt 1 ]]; then
		echo kpcli already open
	else
		kpcli --kdb ~/pw.kdb && clear
	fi
}

set -o vi
export EDITOR=vim
