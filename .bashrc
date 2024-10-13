parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\w \$(parse_git_branch) "

alias l='ls -lh --color'
alias ll='ls -lah --color'
alias rr='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias fzf='fzf --preview="cat {}"'
alias fzfc='fzf --preview="cat {}" | pbcopy'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

export PATH="$PATH:~/.config/bin/"

EDITOR="/usr/local/bin/nvim"
VISUAL="/usr/local/bin/nvim"

tmux source-file ~/.config/tmux/.tmux.conf

export HISTFILESIZE=
export HISTSIZE=

