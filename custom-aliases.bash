#!/usr/bin/env bash
#

# easily share stuff
alias shareit='python -m SimpleHTTPServer 8000 ; sudo localtunnel -k ~/.ssh/id_rsa.pub 8000'

# misc
alias bcat='pygmentize -O style=monokai -f console256 -g'
alias ccat='pygmentize -O bg=dark'
alias cd..='cd ..'
alias cdh='cd ~/'
alias ducks='du -cks *|sort -rn|head -11'
alias grep='grep --color=auto'
alias json='python -mjson.tool'
alias lsd='ls -l | grep "^d"'
alias lst='ls -AlFhrt'
alias mkdir='mkdir -p -v'
#alias musique='sudo mount.cifs //kropotkine/music /media/musique -o user=toma,file_mode=0777,dir_mode=0777'
#alias node='env NODE_NO_READLINE=1 rlwrap -p Green -S "node >>> " node'
alias nzgrep='grep -v "^\s*$\|^\s*#.*"'
alias psc='ps xawf -eo pid,user,cgroup,args'
alias shl="source-highlight -o STDOUT -f esc -i /dev/stdin -s"
alias spy='spy () { lsof -i -P +c 0 +M | grep -i "$1" }'
alias sulast='sudo $(history -p !-1)'
alias sweep='find ~ -type f \( -name '*.swp' -o -name 'wget.log' -o -name 'foobar*' -o -name '*~' -o -name '.netrwhist'  \) -delete'
alias topy='tmux attach -t topy || tmux new-session -s topy -d "htop" \; rename-window htop \; split-window -v -p 15 "iotop -o" \; attach -t topy'
alias vimless='/usr/share/vim/vim73/macros/less.sh'
#alias whois="whois -h whois-servers.net"

# dl from ftp/site
alias dldir="wget -c -nd -r -l 0 -np"
alias aria2c="aria2c --console-log-level=error --check-integrity --bt-hash-check-seed=false -c"
alias wget-all='wget --user-agent=Mozilla -e robots=off --content-disposition --mirror --convert-links -E -K -N -r -c'

# less stuff
alias m='less -x4RFsX'

# ssh stuff
alias ssh-config="$EDITOR ~/.ssh/config"
#salt generation
alias genSalt='openssl rand -base64 32'

#git relative
#alias gl='git log --graph --full-history --all --color'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit -m'
alias gd='git diff'
alias gitclean='find . -maxdepth 2 -type d -name '.git' -print0 | while read -d ""; do (cd "$REPLY"; git gc); done'
alias gitcountcommits="git log --pretty=format:'' | wc -l"
alias gitcountfiles="git ls-files | wc -l"
alias github="chromium-browser \`git remote -v | grep github.com | grep fetch | head -1 | field 2 | sed 's/git:/http:/g'\`"
alias gitlog2='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias gitlog3="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gitlog='git log -n 20 --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset %an'\'' --abbrev-commit --date=relative'
alias gitsearch='git rev-list --all | xargs git grep -F'
alias gp='git push'
alias gs='git status' #N.B. Overrides ghostscript (probably not important if you don't use it)
#alias gitprompt="export PS1=\[\033]0;$(__title_bar)\007\][\u@\h \W$(__git_tags | tail -n1 | perl -pe '"'"'s/^(.+)$/ ($1)/'"'"')$(__git_ps1 " (%s)")]\$"

#apache
alias elog='tail -f /var/log/apache2/error.log'

#python stuff
alias covertest='coverage run -m unittest discover tests/'
alias formatpep8="autopep8 -r -i ."
alias pipupdate="pip freeze --local | grep -v -E '(^Django\=|^\-f|^\-e)' | cut -d = -f 1  | xargs pip install -U"
alias venvproject="setvirtualenvproject $VIRTUAL_ENV $(pwd)"

#symfony
alias scc='php symfony cc'

#django
alias djangoserver='python manage.py runserver'

# vagrant boxes ssh
alias vagrantdev='ssh vagrant@192.168.1.2'
alias vagrantdev2='ssh vagrant@192.168.1.3'
alias vagrantcopyid='ssh-copy-id vagrant@192.168.1.2 && ssh-copy-id vagrant@192.168.1.3'

# misc
alias bashitmaj='cd ~/.bash_it && git pull && cd custom && git pull && cd ~'
alias big-files='find -type f -ls | sort -k7 -r -n | head -20'
alias big='du -cks *|sort -rn|head -20'
alias lsbig="echo -n listing files & directories by size | pv -qL 10 && ls -lSrh | ccze -A"
alias ds='du -ks *|sort -n'
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'
alias ifconfig-ext='curl ifconfig.me' # Or: ip.appspot.com
alias netlisteners='lsof -i -P | grep LISTEN'
alias psmem='ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 6 | tail -15'
alias toprun="ps axo %cpu,%mem,comm |sort -unr| head -n 9 | ccze -A" #top processes
alias hist="history -n 20 | ccze -A"    #shell history
alias psusage="ps aux  --sort=-%cpu | grep -m 11 -v `whoami` | ccze -A"  #cpu load
alias nstat="netstat -p TCP -eWc | ccze -A" 
alias fact='wget randomfunfacts.com -O - 2>/dev/null | grep \<strong\> | sed "s;^.*<i>\(.*\)</i>.*$;\1;"'
alias kindlesend='mutt bastardkindlefromhell@kindle.com -s "new book" -a'
alias tortuga='pirate-get -C "peerflix %s -v -d -n -l -t"'

# leekloud webgame
alias leekloud='node ~/Dev/leekwars/LeeKloud/_LeeKloud.js'

# vpn stuff
alias vpnroute='sudo route add -net 130.79.0.0 netmask 255.255.0.0 gw 130.79.203.254 dev eth0'

# weather 
alias weatherfc='echo -n "Meteo de la semaine à Strasbourg  " | pv -qL 20 && weatherman -x "Strasbourg,France" | ccze -A'
alias weather='echo -n "Meteo Strasbourg  " | pv -qL 20 && weatherman  "Strasbourg,France" '
alias mtv="mpv http://83.218.202.202:1935/live/wt_mtv.stream/playlist.m3u8"
#  specific os relatives alias
OS="`uname`"
case $OS in
  'Linux')
    OS='Linux'
    alias ls='ls --color=auto'
    
    #ubuntu relative
    alias apt-foreign="aptitude search ~o"
    alias aptmaj="sudo apt-fast update && sudo apt-fast upgrade -y && sudo apt-fast clean"
    alias install-essential="sudo add-apt-repository ppa:ricotz/docky;sudo apt-get update; sudo apt-get install php5-common libapache2-mod-php5 php5-cli git plank vim skype guake chromium-browser git firefox vlc filezilla"
    
    #arch linux relatives
    alias pacc="sudo pacman -Scc"           # Clean cache - delete all not currently installed package files
    alias pacexpl="pacman -D --asexp"       # Mark one or more installed packages as explicitly installed
    alias pacimpl="pacman -D --asdep"       # Mark one or more installed packages as non explicitly installed
    alias pacin='sudo pacman -S'            # Install specific package(s) from the repositories
    alias pacins='sudo pacman -U'           # Install specific package not from the repositories but from a file
    alias paclf="pacman -Ql"                # List all files installed by a given package
    alias paclo="pacman -Qdt"               # List all packages which are orphaned
    alias pacloc='pacman -Qi'               # Display information about a given package in the local database
    alias paclocs='pacman -Qs'              # Search for package(s) in the local database
    alias pacre='sudo pacman -R'            # Remove the specified package(s), retaining its configuration(s) and required dependencies
    alias pacrem='sudo pacman -Rns'         # Remove the specified package(s), its configuration(s) and unneeded dependencies
    alias pacrep='pacman -Si'               # Display information about a given package in the repositories
    alias pacreps='pacman -Ss'              # Search for package(s) in the repositories
    alias pacupg='sudo pacman -Syu'         # Synchronize with repositories and then upgrade packages that are out of date on the local system.
    # '[r]emove [o]rphans' - recursively remove ALL orphaned packages
    alias pacro="pacman -Qtdq > /dev/null && sudo pacman -Rns \$(pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')"
    # Additional pacman alias examples
    alias archmaj='~/Scripts/News.sh  && yaourt -Syua'
    alias pacinsd='sudo pacman -S --asdeps'            # Install given package(s) as dependencies
    alias pacmir='sudo pacman -Syy'                    # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist
    alias pacupd='sudo pacman -Sy && sudo abs'         # Update and refresh the local package and ABS databases against repositories
    alias sc='sudo systemctl' #
    
    #misc
    #
    # byzanz screencaster to gif
    # sudo add-apt-repository ppa:fossfreedom/byzanz
    # sudo apt-get update && sudo apt-get install byzanz
    alias gifcast='byzanz-record --duration=15 --x=200 --y=300 --width=700 --height=400 out.gif'
    
    # secure mv & rm
    alias mv=' timeout 8 mv -iv'
    alias rm=' timeout 3 rm -Iv --one-file-system'
    alias 'o'='xdg-open' 
    alias archerrors='echo -n Journal Errors | pv -qL 10 && journalctl -b -p err | ccze -A'
    alias systemdmsg="sudo journalctl /usr/lib/systemd/systemd | ccze -A"
    alias blame="systemd-analyze blame | ccze -A"  
    alias boot="echo -n Boot Time | pv -qL 10 && systemd-analyze | ccze -A"
    alias units="echo -n Listing Units | pv -qL 10 && systemctl list-units | ccze -A"
    
    ;;
  'FreeBSD')
    OS='FreeBSD'
    alias ls='ls -G'
    ;;
  'WindowsNT')
    OS='Windows'
    ;;
  'Darwin')
    OS='Mac'
    
    #osx specific
    alias airdropoff="defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool FALSE; killall Finder"
    alias airdropon="defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool TRUE; killall Finder"
    alias brewmaj="brew update && brew upgrade --all && brew cask update && brew cleanup && brew cask cleanup"
    alias cleandownload="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
    alias DiskUtility_debug='defaults write com.apple.DiskUtility DUDebugMenuEnabled 1' # http://osxdaily.com/2011/09/23/view-mount-hidden-partitions-in-mac-os-x/
    alias dockspace="defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'"
    alias ebin="rm -rf ~/.Trash/*"
    alias eject_force="diskutil unmountDisk force"
    alias finder='open -a Finder ./'
    alias flushdns="dscacheutil -flushcache"
    alias histdownload="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent'"
    alias kcrash_verbose='sudo nvram boot-args="-v keepsyms=y"'
    alias osxpg_start="postgres -D /usr/local/var/postgres"
    alias portmaj="sudo port selfupdate -v && sudo port upgrade outdated -v"
    alias quiet_boot="sudo nvram SystemAudioVolume=%80"
    alias sound_boot="sudo nvram -d SystemAudioVolume"
    alias sql_istat='grep -oE "INTO `\w+`" | grep -oE "`\w+`" | sort | uniq -c | sort -nr'
    alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
    alias swap_off="sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist"
    alias swap_on="sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist"
    ;;
  'SunOS')
    OS='Solaris'
    ;;
  'AIX') ;;
  *) ;;
esac




