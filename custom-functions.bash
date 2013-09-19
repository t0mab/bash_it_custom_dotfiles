#!/usr/bin/env bash
#

#t() {
#    (( $+1 )) || {
#                     tmux ls | sed 's/:.*//'
#                     return
#                 }
#   tmux att -t $1 || tmux new -s $1
#}


#
# MISC
#

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
git_rm_submodule() {
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


rgc() {
    git commit -m"`curl -s http://whatthecommit.com/index.txt`"
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

sssh (){ ssh -t "$1" 'tmux attach || tmux new || screen -DR'; }


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