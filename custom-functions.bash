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
