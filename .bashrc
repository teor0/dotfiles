### EXPORT ###
export EDITOR='vim'
export VISUAL='vim'
export HISTCONTROL=ignoreboth:erasedups
export PAGER='most'

#Ibus settings if you need them
#type ibus-setup in terminal to change settings and start the daemon
#delete the hashtags of the next lines and restart
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=dbus
#export QT_IM_MODULE=ibus

PS1='[\u@\h \W]\$ '

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"


# show the list of packages that need this package - depends mpv as example
#function_depends()  {
 #   search=$(echo "$1")
  #  sudo pacman -Sii $search | grep "Required" | sed -e "s/Required By     : //g" | sed -e "s/  /\n/g"
   # }

#alias depends='function_depends'

#fix obvious typo's
alias cd..='cd ..'
alias pdw='pwd'
alias udpate='sudo apt upgrade'
alias upate='sudo apt upgrade'
alias updte='sudo apt upgrade'
alias updqte='sudo apt upgrade'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#readable output
alias df='df -h'

#pacman unlock
alias unlock="sudo rm /var/lib/pacman/db.lck"

#free
alias free="free -mt"

#userlist
alias userlist="cut -d: -f1 /etc/passwd | sort"

# Aliases for software managment
# pacman or pm
alias update='sudo apt upgrade'

#ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

#grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"

#add new fonts
alias update-fc='sudo fc-cache -fv'

#switch between bash and zsh
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"

#hardware info --short
alias hw="hwinfo --short"

#fastfetch --short
alias ff="fastfetch"

#audio check pulseaudio or pipewire
alias audio="pactl info | grep 'Server Name'"

#approximation of how old your hardware is
alias howold="sudo lshw | grep -B 3 -A 8 BIOS"

#check cpu
alias cpu="cpuid -i | grep uarch | head -n 1"

#shopt
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases

#youtube download
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias ytv-best="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 "

#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

#Cleanup orphaned packages
alias cleanup='sudo apt autoremove'

#clear
alias clean="clear; seq 1 $(tput cols) | sort -R | sparklines | lolcat"

#search content with ripgrep
alias rg="rg --sort path"

#get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

#systeminfo
alias probe="sudo -E hw-probe -all -upload"
alias sysfailed="systemctl list-units --failed"

#shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="reboot"

#give the list of all installed desktops - xsessions desktops
alias xd="ls /usr/share/xsessions"
alias xdw="ls /usr/share/wayland-sessions"

#give a list of the kernels installed
alias kernel="ls /usr/lib/modules"
alias kernels="ls /usr/lib/modules"

#am I on grub,systemd-boot or refind
alias boot="sudo /usr/local/bin/arcolinux-boot"

#moving your personal files and folders from /personal to ~
alias personal='cp -Rf /personal/* ~'

#create a file called .bashrc-personal and put all your personal aliases
#in there. They will not be overwritten by skel.

[[ -f ~/.bashrc-personal ]] && . ~/.bashrc-personal

function ex {
if [ -z "$1" ]; then
   # display usage if no parameters given
   echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
else
   if [ -f "$1" ] ; then
       NAME=${1%.*}
       #mkdir $NAME && cd $NAME
       case "$1" in
         *.tar.bz2)   tar xvjf ./"$1"    ;;
         *.tar.gz)    tar xvzf ./"$1"    ;;
         *.tar.xz)    tar xvJf ./"$1"    ;;
         *.lzma)      unlzma ./"$1"      ;;
         *.bz2)       bunzip2 ./"$1"     ;;
         *.rar)       unrar x -ad ./"$1" ;;
         *.gz)        gunzip ./"$1"      ;;
         *.tar)       tar xvf ./"$1"     ;;
         *.tbz2)      tar xvjf ./"$1"    ;;
         *.tgz)       tar xvzf ./"$1"    ;;
         *.zip)       unzip ./"$1"       ;;
         *.Z)         uncompress ./"$1"  ;;
         *.7z)        7z x ./"$1"        ;;
         *.xz)        unxz ./"$1"        ;;
         *.exe)       cabextract ./"$1"  ;;
         *)           echo "extract: '$1' - unknown archive method" ;;
       esac
   else
       echo "'$1' - file does not exist"
   fi
fi
}

PATH="$PATH:/usr/local/texlive/2025/bin/x86_64-linux"
