# zsh config file

# colors and prompt
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd # autocd in the written directory
stty stop undef # disable ctrl-s to freeze terminal
setopt interactive_comments

# history into cache
HISTFILE=~/.cache/zsh/history
HISTSIZE=50000
SAVEHIST=10000

# autocomplete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) #include hidden file


# vi mode
bindkey -v
export KEYTIMEOUT=1

# vim comands in completition menu
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
alias udpate='sudo pacman -Syyu'
alias upate='sudo pacman -Syyu'
alias upadte='sudo pacman -Syyu'
alias updaet='sudo pacman -Syyu'
alias udapte='sudo pacman -Syyu'

# alias for fast software update
alias update='sudo pacman -Syyu'

# colorful grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"

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
echo "Enter cmds for custom commands recap"
xrdb ~/.config/.Xresources
# syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
