# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

source $ZSH/oh-my-zsh.sh
tmux source-file ~/.config/tmux/.tmux.conf

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

alias hw='cd ~/programming/semester2'
alias wt='cd ~/programming/worktrees'
alias l='eza --git -lh'
alias ll='eza --git -lah'
alias rr='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias wmrestart='yabai --restart-service && skhd --restart-service'
alias matrix='cmatrix -C Cyan'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
