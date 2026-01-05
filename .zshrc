# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 2> /dev/null
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null

setopt autocd # autocd in the written directory
setopt interactive_comments

# history into cache
HISTFILE=~/.cache/zsh/history
HISTSIZE=50000
SAVEHIST=10000

# auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) #include hidden file


# enter vi mode with escape
bindkey -v
export KEYTIMEOUT=1

# vim keys in completition menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# cursor
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		 [[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main ]] ||
			 [[ ${KEYMAP} == viins ]] ||
			 [[ ${KEYMAP} == '' ]] ||
			 [[ $1 = 'line' ]];then
			echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select
zle-line-init() {
	zle -K viins
	echo -ne '\e[5 q'
}
zle -N zle-line-init
echo -ne '\e[1 q' # block cursor default
preexec() { echo -ne '\e[1 q' ;} # use block cursor on new prompt

# modify comands with vim via ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# fix typo's
alias cd..='cd ..'
alias pdw='pwd'
alias udpate='sudo apt update; sudo apt upgrade'
alias upate='sudo apt update; sudo apt upgrade'
alias upadte='sudo apt update; sudo apt upgrade'
alias updaet='sudo apt update; sudo apt upgrade'
alias udapte='sudo apt update; sudo apt upgrade'

# alias for fast software update
alias update='sudo apt update; sudo apt upgrade'

#alias for bat
alias "bat=batcat"

# alias for lsd
alias "ls=lsd"

# alias for cleanup
alias cleanup='sudo apt autoremove'

# colorful grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ex = EXtractor for all kinds of archives
# usage: ex <file>
ex ()
{
	if [ -f $1 ];then
		case $1 in
			*.tar.bz2) tar xjf $1 ;;
			*.tar.gz) tar xzf $1  ;;
			*.bz2) bunzip2 $1     ;;
			*.rar) unrar x $1     ;;
			*.gz) gunzip $1       ;;
			*.tar) tar xf $1      ;;
			*.tbz2) tar xjf $1    ;;
			*.tgz) tar xzf $1     ;;
			*.zip) unzip $1       ;;
			*.Z)  uncompress $1   ;;
			*.7z) 7z x $1         ;;
			*.deb) ar x $1        ;;
			*.tar.xz) tar xf $1   ;;
			*.tar.zst) tar xf $1  ;;
			*) echo "$1 cannot be extracted via ex()" ;;
		esac
	else
		echo "$1 in not a valid file"
	fi
}


# various
PATH=$PATH:.
PATH="$PATH:/usr/local/texlive/2025/bin/x86_64-linux"
PATH="$PATH:/usr/local/texlive/2025/bin/x86_64-linux/pdflatex"
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
