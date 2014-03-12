#!/usr/bin/env bash
#

# easily share stuff
alias shareit='python -m SimpleHTTPServer 8000 ; sudo localtunnel -k ~/.ssh/id_rsa.pub 8000'

# misc
alias sweep='find ~ -type f \( -name '*.swp' -o -name 'wget.log' -o -name 'foobar*' -o -name '*~' -o -name '.netrwhist'  \) -delete'
alias cd..='cd ..'
alias musique='sudo mount.cifs //kropotkine/music /media/musique -o user=toma,file_mode=0777,dir_mode=0777'
alias ducks='du -cks *|sort -rn|head -11'
alias ccat='pygmentize -O bg=dark'
alias bcat='pygmentize -O style=monokai -f console256 -g'
alias sulast='sudo $(history -p !-1)'
alias whois="whois -h whois-servers.net"
alias nzgrep='grep -v "^\s*$\|^\s*#.*"'
alias shl="source-highlight -o STDOUT -f esc -i /dev/stdin -s"
alias lsd='ls -l | grep "^d"'
alias apt-foreign="aptitude search ~o"
alias topy='tmux attach -t topy || tmux new-session -s topy -d "htop" \; rename-window htop \; split-window -v -p 15 "iotop -o" \; attach -t topy'
alias vimless='/usr/share/vim/vim73/macros/less.sh'
alias psc='ps xawf -eo pid,user,cgroup,args'
alias spy='spy () { lsof -i -P +c 0 +M | grep -i "$1" }'
alias json='python -mjson.tool'

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
alias gitsearch='git rev-list --all | xargs git grep -F'
alias gitclean='find . -maxdepth 2 -type d -name '.git' -print0 | while read -d ""; do (cd "$REPLY"; git gc); done'
alias gitlog='git log -n 20 --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset %an'\'' --abbrev-commit --date=relative'
alias gitcountfiles="git ls-files | wc -l"
alias gitcountcommits="git log --pretty=format:'' | wc -l"
alias github="chromium-browser \`git remote -v | grep github.com | grep fetch | head -1 | field 2 | sed 's/git:/http:/g'\`"

#ubuntu relative
alias aptmaj="sudo apt-fast update && sudo apt-fast upgrade -y && sudo apt-fast clean"

#osx specific
alias finder='open -a Finder ./'
alias histdownload="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent'"
alias cleandownload="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
alias subl='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'
alias portmaj="sudo port selfupdate -v && sudo port upgrade outdated -v"
alias brewmaj="brew update && brew upgrade"
alias quiet_boot="sudo nvram SystemAudioVolume=%80"
alias sound_boot="sudo nvram -d SystemAudioVolume"
alias ebin="rm -rf ~/.Trash/*"
alias dockspace="defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'"
alias ebin="rm -rf ~/.Trash/*"

#apache
alias elog='tail -f /var/log/apache2/error.log'

#python stuff
alias pipupdate="pip freeze --local | grep -v -E '(^Django\=|^\-f|^\-e)' | cut -d = -f 1  | xargs pip install -U"

#symfony
alias scc='php symfony cc'

#django
alias djangoserver='python manage.py runserver'

# byzanz screencaster to gif
# sudo add-apt-repository ppa:fossfreedom/byzanz
# sudo apt-get update && sudo apt-get install byzanz
alias gifcast='byzanz-record --duration=15 --x=200 --y=300 --width=700 --height=400 out.gif'
