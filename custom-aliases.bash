#!/usr/bin/env bash
#

# easily share stuff
alias shareit='python -m SimpleHTTPServer 8000 ; sudo localtunnel -k ~/.ssh/id_rsa.pub 8000'

alias cd..='cd ..'
alias musique='sudo mount.cifs //kropotkine/music /media/musique -o user=toma,file_mode=0777,dir_mode=0777'

#salt generation
alias genSalt='openssl rand -base64 32'

#git relative
alias gitsearch='git rev-list --all | xargs git grep -F'
alias gitclean='find . -maxdepth 2 -type d -name '.git' -print0 | while read -d ""; do (cd "$REPLY"; git gc); done'

#ubuntu relative
alias aptmaj="sudo apt-fast update && sudo apt-fast upgrade && sudo apt-fast clean"