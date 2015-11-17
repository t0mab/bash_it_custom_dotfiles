#!/usr/bin/env bash
#

#t() {
#    (( $+1 )) || {
#                     tmux ls | sed 's/:.*//'
#                     return
#                 }
#   tmux att -t $1 || tmux new -s $1
#}

# Tmux tool
tm()
{
  if [ "$1" ];
  then
    tmux att -t $1 || tmux new -s $1
  else
    tmux ls | sed 's/:.*//'
    return
  fi
}

# htpasswd without htpasswd
nohtpasswd()
{
    [ ! $# -eq 2 ] && { echo -e "Usage: nohtpasswd file_name user"; return 1; }
    echo "password:"
    read -s password
    echo -e "$2:`perl -le 'print crypt($password,"salt")'`" >> $1
}

#
# MISC
#

# remove  ^M car from files
# usage: removem /path/to/dir
function removem()
{
    for file in $(find $1 -type f); do
        tr -d '\r' <$file >temp.$$ && mv temp.$$ $file
    done

}

function calibre_upgrade()
{
    sudo python -c "import sys; py3 = sys.version_info[0] > 2; u = __import__('urllib.request' if py3 else 'urllib', fromlist=1); exec(u.urlopen('http://status.calibre-ebook.com/linux_installer').read()); main(install_dir='~/bin')"
}

# mkdir and cd to new dir
function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

function addalias
{
desc="ADD DESCRIPTION..."
  if [ -n "$3" ]; then
  desc="$3"
fi
  echo "" >> ~/.bash_it/custom/custom-aliases.bash
  echo "###" >> ~/.bash_it/custom/custom-aliases.bash
  echo "##

  $desc" >> ~/.bash_it/custom/custom-aliases.bash
  echo "#" >> ~/.bash_it/custom/custom-aliases.bash
  echo "" >> ~/.bash_it/custom/custom-aliases.bash
  echo "alias '$1'='$2'" >> ~/.bash_it/custom/custom-aliases.bash
  source ~/.bash_it/custom/custom-aliases.bash
  echo "" && echo "- Alias added -" && echo ""
}

function calc(){ awk "BEGIN{ print $* }" ;}

#
# git relatives
#

# get current branch, prompt, pull and push
function gplh ()
{
    currentBranch=`git rev-parse --abbrev-ref HEAD`

    git status
    read -p "
    -----------------------------------------------------------------
    You are currently on branch "$currentBranch".
    Are you sure you want to pull and push branch "$currentBranch"?
    [Y] to confirm, [N] to cancel.
    -----------------------------------------------------------------
    " -n 1 -r

    if [[ $REPLY =~ ^[Yy]$ ]]
    then
    git pull origin $currentBranch
    git push origin $currentBranch
    elif [[ $REPLY = * ]]
    then
    echo "
    ------------------------------------------------------------
    User canceled pull and push branch "$currentBranch"?
    ------------------------------------------------------------
    "
    fi
}

function gbl()
{
  git for-each-ref --sort=-committerdate --format='%(committerdate) %(authorname) %(refname)' refs/remotes/origin/|grep -e ".$@"|head -n 10;
}

# Sweep a git submodule out of the working copy
gitrmsubmodule() {
  SMD_PATH=$1
  if [ ! -d $SMD_PATH ]; then
    echo "$SMD_PATH does not exist"
    return 1
  fi

  git config -f .git/config --remove-section submodule.$SMD_PATH
  git config -f .gitmodules --remove-section submodule.$SMD_PATH
  git rm --cached $SMD_PATH
  rm -rf $SMD_PATH
  rm -rf .git/modules/$SMD_PATH
}

function gitolite()  {
  if [ "$#" -lt 2 ]; then
    echo "Usage : gitolite <host> <command> [args ...]"
    return 1;
  fi
  GL_USER=$1
  GL_CMD=$2
  shift
  shift
  ssh "git@$GL_USER" "$GL_CMD" $@
}


gitrandomc() {
    git commit -m"`curl -s http://whatthecommit.com/index.txt`"
 }

function gitretag() {
    git tag -d $1 && git push --delete origin $1 && git tag $1 && git push --tags
}

gitworkdone(){
        default="1 day ago"
            git log --committer=$1 --pretty=format:"%Cgreen%ar (%h)%n%Creset> %s %b%n" --since="${2:-$default}" --no-merges
}

#
# ssh relatives
#

sssh()
{
    ssh -t "$1" 'tmux attach || tmux new || screen -DR';
}

function createTunnel()
{
  if [ $# -eq 3 ]
  then
    user=$1
    host=$2
    localPort=$3
    remotePort=$3
  else
    if [ $# -eq 4 ]
    then
      user=$1
      host=$2
      localPort=$3
      remotePort=$4
    else
      echo -n "User: "; read user
      echo -n "host: "; read host
      echo -n "Distant host: "; read remotePort
      echo -n "Local port: "; read localPort
    fi
  fi
  ssh -N -f $user@$host -L ${localPort}:${host}:${remotePort}
}

function rmhost() { sed -i "$1d" ~/.ssh/known_hosts; }



#
# alias.sh relative
#

function alias-up()
{
    if ([ $# -eq 0 ])
    then
            echo "Usage: getAliasSh AliasUserID"
    else
            wget -q -O - "$@" https://alias.sh/user/"$1"/alias > ~/.bash_aliases
            source ~/.bash_aliases
    fi
}

# alias.sh relative
function alias-bashup()
{
    if ([ $# -eq 0 ])
    then
            echo "Usage: getAliasSh_for_bash_it AliasUserID"
    else
            wget -q -O - "$@" https://alias.sh/user/"$1"/alias > ~/.bash_it/custom/custom-aliases.bash
            source ~/.bash_it/custom/custom-aliases.bash
    fi
}

#
# php relative
#

function chkPhp()
{
  find . -name "*.php" -exec php -l {} \; | grep "Parse error"
}

#
# sniff
#

function sniff ()
{
  sudo ngrep -d ${1} -t '^(GET|POST) ' 'tcp and port 80';
}

#
# use duckduckgo in console
#

function duckduckgo()
{
  curl -s http://api.duckduckgo.com/\?no_html\=1\&format\=xml\&q\="$*" | hxselect -c "Text" ;
}

#
# youtube 2 mp3
#
#

function yt2mp3()
{
  youtube-dl $1 --extract-audio --title --audio-format mp3
}

#
# find classes in jar files
#
#

function findJavaClass()
{
   grep $1 `find . -name '*.jar'`
}

#
# Run dns and reverse-dns queries
#
#
rdns() {
    dig +short $1 | xargs -L 5 nslookup | grep name
}
alias rnds='rdns'

pdf2booklet(){
if [[ $# != 2 ]]; then
   echo "usage pdf2booklet <input> <output>" >&2
   else
   pdf2ps $1 - | psbook | psnup -2 | ps2pdf - $2
fi
}

# encode a given image file as base64 and output css background property to clipboard
function 64enc() {

openssl base64 -in $1 | awk -v ext="${1#*.}" '{ str1=str1 $0 }END{ print "background:url(data:image/"ext";base64,"str1");" }'|pbcopy

echo "$1 encoded to clipboard"
}

# Quickly get image dimensions from the command line
function imgsize() {
	local width height
	if [[ -f $1 ]]; then
		height=$(sips -g pixelHeight "$1"|tail -n 1|awk '{print $2}')
		width=$(sips -g pixelWidth "$1"|tail -n 1|awk '{print $2}')
		echo "${width} x ${height}"
	else
		echo "File not found"
	fi
}

function 64font() {
	openssl base64 -in $1 | awk -v ext="${1#*.}" '{ str1=str1 $0 }END{ print "src:url(\"data:font/"ext";base64,"str1"\")  format(\"woff\");" }'|pbcopy
	echo "$1 encoded as font and copied to clipboard"
}

# to use later
function nom_du_projet {
    workon nom_du_virtualenv;
    cd /chemin/vers/le/projet/django/;
    if [[ $# -ne 0 ]]; then
        ./manage.py $@
    fi
}

# ipython notebook profiler
function notebook () {
    processes=$(ps aux | grep -i -P "ipython notebook" | wc -l)
    if [[ $processes -lt 2 ]]
    then
        nohup ipython notebook --port 8889 --pprint &
    else
        chromium-browser http://127.0.0.1:8889
    fi
}

function tarEncrypt() {
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ];then
    echo -e "Wrong arguments. Script usage:\n" \

    "   tarEncrypt source-folder dest-encrypted-file-name password\n" \

    "   Example: tarEncrypt ./MyFolder myFolder-1-1-1970.encrypted MySecretPasword\n"
    else
        tar zcvf - $1 | openssl des3 -salt -k $3 | dd of=$2;
        echo "The file $2 is created!"
    fi
}


function untarDecrypt() {
    if [ -z "$1" ] || [ -z "$2" ];then
        echo -e "Wrong arguments. Script usage:\n" \
        "   untarDecrypt source-encrypted-file password"
    else
        dd if=$1 | openssl des3 -d -salt -k $2 | tar xzf -
        if [ $? -eq 0 ]; then
            echo -e "\nThe file $1 was extracted successfully.\n"
        else
            echo -e "\nError while decrypting. Probably the given password is wrong.\n"
        fi
    fi
}

# open with sublime text
function st() {
    open -a Sublime\ Text "$@";
}

# refresh bashrc
function refre_sh () {
    . ~/.bashrc
}

# t /path/file word hilight word in tail
function tail_colored() {
  tail -f $1 | sed "s/$2/\x1B[1;31;43m&\x1B[0m/g";
}

# django create dev/test superuser
function django_create_superuser() {
    python -c "from django.db import DEFAULT_DB_ALIAS as database; from django.contrib.auth.models import User; User.objects.db_manager(database).create_superuser('admin', 'admin@admin.com', 'admin')"
}

# copy function
# copy /source/file /destination/file
copy() {
    size=$(stat -c%s $1)
    dd if=$1 &> /dev/null | pv -petrb -s $size | dd of=$2
}

# Change dir via find
# Usage: cdf (dir)
cdf() {
  pushd $(find . -name $1)
}

# Find file
# Usage: ff (file)
ff() {
  find . -name $1
}

# Vim file via find
# Usage: ff (file)
vimf() {
  vim $(find . -name $1)
}

# Allows you to search for any text in any file.
# Usage: ft "my string" *.php
ft() {
  find . -name "$2" -exec grep -il "$1" {} \;
}

# Find duplicate files
# Usage: dups (dir)
dups() {
  fdupes -v && fdupes -rS1 $1 | sed '$!N;s/\n/ /' | sort -n
}

# Find command in history
# Usage: ff (file)
#h() {
#  history | grep $1
#}

hfind() { if [ -z \”$1\” ]; then history; else history | grep \”$@\”; fi; }


# inits project for django-drybone project
# see https://github.com/unistra/django-drybones
# Usage initproject project_name [ -p python_version -d django_version]
# example initproject -p 3 -d 1.8.4
initproject() {
    unset PYTHON_VERSION
    unset PYTHON_PATH
    unset DJANGO_VERSION
    if [ -z "$1" ];then
        echo -e "Missing argument. Script usage:\n" \
        "   initproject project_name [ -p python_version -d django_version]" \
        "   example : initproject -p 3 -d 1.8.4 "
    else
        PROJECT_NAME=$1
        ARGS=`getopt --long -o "p:d:" "$@"`
        eval set -- "$ARGS"
        while true ; do
            case "$1" in
                -p )
                    PYTHON_VERSION=$2
                    shift 2
                ;;
                -d )
                    DJANGO_VERSION=$2
                    shift 2
                ;;
                *)
                    break
                ;;
            esac
        done;
        PYTHON_VERSION_PATH=`which python$PYTHON_VERSION`
        mkvirtualenv $PROJECT_NAME -p "$PYTHON_VERSION_PATH"
        if [ -z "$DJANGO_VERSION" ];then
            pip install "Django>1.8,<1.9"
        else
            pip install Django==$DJANGO_VERSION
        fi
        django-admin.py startproject --template=https://github.com/unistra/django-drybones/tree/django1.8/archive/master.zip --extension=html,rst,ini,coveragerc --name=Makefile $PROJECT_NAME
        cd $PROJECT_NAME
        setvirtualenvproject $VIRTUAL_ENV $(pwd)
        echo "export DJANGO_SETTINGS_MODULE=$PROJECT_NAME.settings.dev" >> $VIRTUAL_ENV/bin/postactivate
        echo "unset DJANGO_SETTINGS_MODULE" >> $VIRTUAL_ENV/bin/postdeactivate
        workon $PROJECT_NAME
        chmod +x manage.py
        pip install -r requirements/dev.txt
    fi
}
# Specific functions for os
OS="`uname`"
case $OS in
  'Linux')
    OS='Linux'
    ;;
  'FreeBSD')
    OS='FreeBSD'
    ;;
  'WindowsNT')
    OS='Windows'
    ;;
  'Darwin')
    OS='Mac'

    # Realpath to provide absolute path with OSX
    # See: http://stackoverflow.com/questions/3572030/bash-script-absolute-path-with-osx
    realpath () {
      [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
    }
    ;;
  'SunOS')
    OS='Solaris'
    ;;
  'AIX') ;;
  *) ;;
esac

extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

## WIKIPEDIA SEARCH FUNCTION ##
wikipediaSearch() {
echo -n -e "\n============================================\n\tWelcome to WikiPedia Search"; echo ""; i=1 ; for line in $(lynx --dump "http://en.wikipedia.org/w/index.php?title=Special%3ASearch&profile=default&search=$1&fulltext=Search" | grep http://en.wikipedia.org/wiki | cut -c7-); do echo $i $line; lines[$i]=$line ;  i=$(($i+1)); done ; echo -n -e "\n============================================\n\tPlease select the link to open - "; read answer; w3m ${lines[$answer]}
}

## ARCHWIKI SEARCH FUNCTION ##
archSearch() {
echo -n -e "\n============================================\n\tWelcome to Arch Wiki Search"; echo ""; i=1 ; for line in $(lynx --dump "https://wiki.archlinux.org/index.php?title=Special%3ASearch&profile=default&search=$1&fulltext=Search" | grep https://wiki.archlinux.org/ | cut -c7-); do echo $i $line; lines[$i]=$line ; i=$(($i+1)); done ; echo -n -e "\n============================================\n\tPlease select the link to open - "; read answer; w3m ${lines[$answer]}
}

haste() { a=$(cat); curl -X POST -s -d "$a" http://hastebin.com/documents | awk -F '"' '{print "http://hastebin.com/"$4}'; }

#boost
function boost(){
clear
sleep 3
echo Boosting...
free -m | sed -n -e '3p' | grep -Po d+
sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
free -m | sed -n -e '3p' | grep -Po d+
echo Boosted!
}

# Arch relatives

clean-cache() {
    paccache -r
    paccache -ruk0
}

remove-orphans() {
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo "No orphaned packages to remove."
    else
        sudo pacman -Rns $(pacman -Qdtq)
    fi
}

alias clean='remove-orphans && clean-cache && sudo pacman-optimize'

broken-links() {
	 sudo find . -type l -! -exec test -e {} \; -print
}

top10() {
	history | awk 'BEGIN {FS="[ \t]+|\\|"} {print $3}' | sort | uniq -c | sort -nr | head
}

#Grep process | Usage: psgrep <process>
psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto;
}
