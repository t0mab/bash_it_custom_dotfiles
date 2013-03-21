#!/usr/bin/env bash
#

# easily share stuff
alias shareit='python -m SimpleHTTPServer 8000 ; sudo localtunnel -k ~/.ssh/id_rsa.pub 8000'
alias sweep='find ~ -type f \( -name '*.swp' -o -name 'wget.log' -o -name 'foobar*' -o -name '*~' -o -name '.netrwhist'  \) -delete'
alias cd..='cd ..'
alias musique='sudo mount.cifs //kropotkine/music /media/musique -o user=toma,file_mode=0777,dir_mode=0777'
alias ducks='du -cks *|sort -rn|head -11'
alias ccat='pygmentize -O bg=dark'
alias bcat='pygmentize -O style=monokai -f console256 -g'
alias sulast='sudo $(history -p !-1)'
alias whois="whois -h whois-servers.net"

# ssh stuff
alias ssh-config="$EDITOR ~/.ssh/config"

#salt generation
alias genSalt='openssl rand -base64 32'

#git relative
alias gitsearch='git rev-list --all | xargs git grep -F'
alias gitclean='find . -maxdepth 2 -type d -name '.git' -print0 | while read -d ""; do (cd "$REPLY"; git gc); done'

#ubuntu relative
alias aptmaj="sudo apt-fast update && sudo apt-fast upgrade && sudo apt-fast clean"

#osx specific
alias finder='open -a Finder ./'
alias histdownload="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent'"
alias cleandownload="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
alias vimless='/usr/share/vim/vim73/macros/less.sh'
alias subl='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'
alias portmaj="sudo port selfupdate -v && sudo port upgrade outdated -v"
#apache
alias elog='tail -f /var/log/apache2/error.log'

#symfony
alias scc='php symfony cc'
