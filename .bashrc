parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\w \$(parse_git_branch) "

alias l='ls -l --color'
alias ll='ls -la --color'
alias rr='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias wmrestart='yabai --restart-service && skhd --restart-service'
alias matrix='cmatrix -C Cyan'
#alias fzf='fzf --preview=\"bat --color=always {}\"'
alias fzf='fzf --preview="cat {}"'
alias fzfn='nvim $(fzf -m --preview="cat {}")'
alias fzfc='fzf --preview="cat {}" | pbcopy'
alias icat="kitty +kitten icat --align=left"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

function vimf() {
    vim $(grep -rl "$1" | fzf -m) 
}
function nvimf() { 
    nvim $(grep -rl "$1" | fzf -m) 
}
export -f vimf
export -f nvimf

EDITOR="/usr/bin/vim"
VISUAL="/usr/bin/vim"

tmux source-file ~/.config/tmux/.tmux.conf

