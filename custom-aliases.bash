#!/usr/bin/env bash
#

# easily share stuff
alias shareit='python -m SimpleHTTPServer 8000 ; sudo localtunnel -k ~/.ssh/id_rsa.pub 8000'

# misc
alias sweep='find ~ -type f \( -name '*.swp' -o -name 'wget.log' -o -name 'foobar*' -o -name '*~' -o -name '.netrwhist'  \) -delete'
alias cd..='cd ..'
#alias musique='sudo mount.cifs //kropotkine/music /media/musique -o user=toma,file_mode=0777,dir_mode=0777'
alias ducks='du -cks *|sort -rn|head -11'
alias ccat='pygmentize -O bg=dark'
alias bcat='pygmentize -O style=monokai -f console256 -g'
alias sulast='sudo $(history -p !-1)'
#alias whois="whois -h whois-servers.net"
alias grep='grep --color=auto'
alias mkdir='mkdir -p -v'
alias mv=' timeout 8 mv -iv'
alias rm=' timeout 3 rm -Iv --one-file-system'
alias nzgrep='grep -v "^\s*$\|^\s*#.*"'
alias shl="source-highlight -o STDOUT -f esc -i /dev/stdin -s"
alias lsd='ls -l | grep "^d"'
alias lst='ls -AlFhrt'
alias apt-foreign="aptitude search ~o"
alias topy='tmux attach -t topy || tmux new-session -s topy -d "htop" \; rename-window htop \; split-window -v -p 15 "iotop -o" \; attach -t topy'
alias vimless='/usr/share/vim/vim73/macros/less.sh'
alias psc='ps xawf -eo pid,user,cgroup,args'
alias spy='spy () { lsof -i -P +c 0 +M | grep -i "$1" }'
alias json='python -mjson.tool'
#alias node='env NODE_NO_READLINE=1 rlwrap -p Green -S "node >>> " node'
alias formatpep8="autopep8 -r -i ."

# dl from ftp/site
alias dldir="wget -c -nd -r -l 0 -np"
alias aria2c="aria2c --console-log-level=error --check-integrity --bt-hash-check-seed=false -c"

# less stuff
alias m='less -x4RFsX'

# ssh stuff
alias ssh-config="$EDITOR ~/.ssh/config"

#salt generation
alias genSalt='openssl rand -base64 32'

#git relative

alias gs='git status' #N.B. Overrides ghostscript (probably not important if you don't use it)
alias gd='git diff'
alias gc='git commit -m'
#alias gl='git log --graph --full-history --all --color'
alias ga='git add'
alias gaa='git add -A'
alias gp='git push'
alias gitsearch='git rev-list --all | xargs git grep -F'
alias gitclean='find . -maxdepth 2 -type d -name '.git' -print0 | while read -d ""; do (cd "$REPLY"; git gc); done'
alias gitlog='git log -n 20 --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset %an'\'' --abbrev-commit --date=relative'
alias gitlog2='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias gitlog3="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gitcountfiles="git ls-files | wc -l"
alias gitcountcommits="git log --pretty=format:'' | wc -l"
alias github="chromium-browser \`git remote -v | grep github.com | grep fetch | head -1 | field 2 | sed 's/git:/http:/g'\`"

#ubuntu relative
alias aptmaj="sudo apt-fast update && sudo apt-fast upgrade -y && sudo apt-fast clean"
alias install-essentiel="sudo add-apt-repository ppa:ricotz/docky;sudo apt-get update; sudo apt-get install php5-common libapache2-mod-php5 php5-cli git plank vim skype guake chromium-browser git firefox vlc filezilla"
#osx specific
alias finder='open -a Finder ./'
alias histdownload="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent'"
alias cleandownload="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias portmaj="sudo port selfupdate -v && sudo port upgrade outdated -v"
alias brewmaj="brew update && brew upgrade && brew cask update"
alias quiet_boot="sudo nvram SystemAudioVolume=%80"
alias sound_boot="sudo nvram -d SystemAudioVolume"
alias ebin="rm -rf ~/.Trash/*"
alias dockspace="defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'"
alias ebin="rm -rf ~/.Trash/*"
alias airdropon="defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool TRUE; killall Finder"
alias airdropoff="defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool FALSE; killall Finder"

alias osxpg_start="postgres -D /usr/local/var/postgres"
#apache
alias elog='tail -f /var/log/apache2/error.log'

#python stuff
alias pipupdate="pip freeze --local | grep -v -E '(^Django\=|^\-f|^\-e)' | cut -d = -f 1  | xargs pip install -U"
alias covertest='coverage run -m unittest discover tests/'

#symfony
alias scc='php symfony cc'

#django
alias djangoserver='python manage.py runserver'

# byzanz screencaster to gif
# sudo add-apt-repository ppa:fossfreedom/byzanz
# sudo apt-get update && sudo apt-get install byzanz
alias gifcast='byzanz-record --duration=15 --x=200 --y=300 --width=700 --height=400 out.gif'

alias leekloud='node ~/Dev/leekwars/LeeKloud/_LeeKloud.js'

<<<<<<< Updated upstream
#arch linux relatives

alias pacupg='sudo pacman -Syu'         # Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacin='sudo pacman -S'            # Install specific package(s) from the repositories
alias pacins='sudo pacman -U'           # Install specific package not from the repositories but from a file 
alias pacre='sudo pacman -R'            # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'         # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'               # Display information about a given package in the repositories
alias pacreps='pacman -Ss'              # Search for package(s) in the repositories
alias pacloc='pacman -Qi'               # Display information about a given package in the local database
alias paclocs='pacman -Qs'              # Search for package(s) in the local database
alias paclo="pacman -Qdt"               # List all packages which are orphaned
alias pacc="sudo pacman -Scc"           # Clean cache - delete all not currently installed package files
alias paclf="pacman -Ql"                # List all files installed by a given package
alias pacexpl="pacman -D --asexp"       # Mark one or more installed packages as explicitly installed 
alias pacimpl="pacman -D --asdep"       # Mark one or more installed packages as non explicitly installed

# '[r]emove [o]rphans' - recursively remove ALL orphaned packages
alias pacro="pacman -Qtdq > /dev/null && sudo pacman -Rns \$(pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')"

# Additional pacman alias examples
alias pacupd='sudo pacman -Sy && sudo abs'         # Update and refresh the local package and ABS databases against repositories
alias pacinsd='sudo pacman -S --asdeps'            # Install given package(s) as dependencies
alias pacmir='sudo pacman -Syy'                    # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

#
alias archupdate='~/Scripts/News.sh  && yaourt -Syua'

