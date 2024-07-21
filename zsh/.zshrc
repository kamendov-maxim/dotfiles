#source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/Cellar/zsh-autosuggestions/0.7.0/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/Cellar/zsh-syntax-highlighting/0.8.0/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

PS1="%1~ $(parse_git_branch) "

precmd() {
    PS1="%1~ $(parse_git_branch) "
}

alias l='eza --git -lh'
alias ll='eza --git -lah'
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
alias /="cd /"

EDITOR="/usr/bin/vim"
VISUAL="/usr/bin/vim"

tmux source-file ~/.config/tmux/.tmux.conf
