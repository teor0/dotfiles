# zsh config file

# colors e prompt
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd #autocd by writing the dir name
stty stop undef #disable ctrl-s
setopt interactive_comments

# history nella cache
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

# vim comands for complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# cursor shapes
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
echo -ne '\e[1 q' # block cursor by default
preexec() { echo -ne '\e[1 q' ;} # block cursor on new prompt

# modify line with vim via ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
#syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
