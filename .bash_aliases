# General aliases
alias grskj='java -jar ~/tn5250j/lib/tn5250j.jar'
alias python='python3'
alias pip='pip3'

# reload config
alias rc='. ~/.bashrc'
###########################

# helper functions
mkill() {
    if [ -z $1 ]; then
        echo 'usage: mkill <rg>'
        return
    fi

    ps aux | rg vagrant | awk '{ print $2}' | while read r ; do kill $r ; done
}


ipecho() {
    if [ -z $1 ]; then
        echo 'usage: ipecho <host>'
    fi

    echo "$(ping -c 1 $1 | awk 'NR==1 {print substr($3, 2, length($3) - 2)}')"
}

azsid() {
    if [ -z $1 ]; then
        echo 'usage: azsid <subscription name>'
    fi

    echo "$(az account list | jq ".[] | select (.name == \"$1\").id" | awk '{print substr($1, 2, length($1) - 2)}')"
}

azGetKvVal() {
    if [ -z $1 ] || [ -z $2 ]; then
        echo 'usage: azGetKvVal <subscription> <secretname>'
        return
    fi

    kv="kvdriw${1}"

    echo "$(az keyvault secret show --vault-name $kv --name $2 | jq .value | awk '{ print substr($1, 2, length($1) - 2)}')"
}

sdkInstalledVersions() {
    if [ -z $1 ]; then
        echo 'usage: sdkInstalledVersions <sdk name>'
        return
    fi

    sdk ls $1 | awk -F\| '{gsub(/^[ \t]+/, "", $5); gsub(/[ \t]+$/, "", $5); if ($5 == "installed" || $5 == "local only") { gsub(/[ \t]+/, "", $6); print $6 }}'
}
alias sdki="sdkInstalledVersions"

sdkUseVersion() {
    if [ -z $1 ] || [ -z $2 ]; then
        echo 'usage: sdkUseVersion <sdk name> <version regex>'
        return
    fi

    sdk use $1 $(sdki $1 | awk -v version=$2 '{regex="^"version; if ($1 ~ regex) { print $1 }}')
}
alias sdku='sdkUseVersion'

sdkUpdate() {
    if [ -z $1 ] || [ -z $2 ]; then
        echo 'usage sdkUpdate <skd name> <version regex>'
        return
    fi

    curVer=$(sdki $1 | awk -v version=$2 '{regex="^"version; if ($1 ~ regex) { ver = gensub(/(.*)([0-9]+\.[0-9]+\.[0-9]+)(.*)/, "\\2", "g", $1); print ver }}')
    patchNum=$(echo $curVer | awk '{ split($0, arr, "."); print arr[3] }')
    echo $curVer
    echo $patchNum

    highVer=$(sdk ls $1 | awk -v version=$2 -F\| '{regex="^"version; gsub(/^[ \t]+/, "", $6); gsub(/[ \t]$/, "", $6); if ($6 ~ regex) { ver = gensub(/(.*)([0-9]+\.[0-9]+\.[0-9]+)(.*)/, "\\2", "g", $6); print ver }}' | )
}
###########################

# countdown
countdown() {

  if [ -z $1 ]; then
      echo 'format: countdown <seconds>'
      return
  fi
 
  date1=$((`date +%s` + $1))

  while [ "$date1" -ge `date +%s` ]; do 
    echo -ne "$(date -u --date @$(($date1 - `date +%s` )) +%H:%M:%S)\r"
     sleep 0.2
  done
}
alias cntd='countdown'
###########################


# witron
wpc() {
  http -a driwkraft:$1 POST http://$2/pick/api/orders/$3/close
}

wpcv() {
  wpc $1 'vini02' $2
}

wpcs() {
  wpc $1 'svgise02' $2
}

wpcm() {
  params=("$@")
  for ((i = 2; i < ${#params[@]}; i++)) do
    wpc $1 $2 ${params[$i]}
  done
}
###########################

# tmux
alias tx='tmux'
alias txls='tmux ls'
alias txr='tmux attach-session -t'
alias txn='tmux new -s'
alias txk='tmux kill-session -t'
###########################


# vim shortcuts
alias vbal='vim ~/dotfiles/.bash_aliases'
###########################

# remap cat to bat
alias cat='bat'
###########################

# exa
#alias ls='exa'
alias el='exa -alh --git'
alias ea='exa -aF'
alias e='exa -F --grid'
alias e1='exa -1'

alias et='el --tree'
alias et2='el --tree --level 2'
alias et3='el --tree --level 3'

# rebind ls aliases
alias ll='el'
alias la='ea'
alias l='e'
alias l1='e1'
###########################

# reckon
createTag() {

  if [ "$#" -eq 1 ]; then
    stage='final'

    if [ -z $1 ]; then
      echo 'Usage reckonTagCreate <scope>'
      return # wrong params
    fi
    scope=$1
  else
    if [[ -z $1 || -z $2 ]]; then
      echo 'Usage: reckonTagCreate [stage] <scope>'
      echo 'stage - defaults to "final"'
      return # wrong params
    fi

    stage=$1
    scope=$2
  fi

  gw reckonTagCreate -Preckon.stage=$stage -Preckon.scope=$scope
}

pushLastTag() {
  last_tag="$(git describe)"

  git push origin $last_tag
}

alias rtc='createTag'
alias rpu='pushLastTag'
###########################

# Custom docker aliases
alias di='docker image'
alias dc='docker container'
alias dps='docker ps'
alias dr='docker run'
alias dri='docker run -it'
alias dlog='docker logs'
alias dlogf='docker logs -f'
###########################

# Git function
## $1 -> branch name
newBranchWithRemote() {
  git checkout -b $1;
  git push -u origin HEAD
}

getBranchName() {
  git symbolic-ref -q --short HEAD || git status | head -1 | awk '{print $1 " -> " $5}'
}
###########################

# Custom git aliases
alias ga='git add'
alias gp='git pull'
alias gpr='git pull --rebase'

alias gf='git fetch --prune'
alias grb='git rebase'

# commit
alias gcm='git commit -m'
alias gc='git commit'
alias gcam='git commit --amend --no-edit'
alias gwip='git commit -am wipall'
alias gst='git status'

# branches
alias gbr='git branch'
alias gbrd='git branch -d'
alias gbrD='gir branch -D'
alias gbrm='git branch --merged'
alias gco='git checkout'
alias gcom='git checkout master'
alias gnbr='git checkout -b'
alias gnbrp='newBranchWithRemote'

# push
alias gpu='git push'
alias gpup='git push -u'
alias gpnbr='git push -u origin head'
alias gplez='git push --force-with-lease'

# resets
alias gsu='git reset --soft HEAD~1'
alias gun='git reset HEAD'
alias gres='git reset --hard'

# stash
alias gss='git stash save'
alias gsa='git stash apply'

# git logging
alias gl='git log'
alias gll='git log -1 HEAD --stat'
showFormat='%C(yellow)%h%Creset%Cred <->%Creset %Cgreen%an%Creset %C(magenta)@%ad%Creset:'
alias gsh='git show --pretty='\"$showFormat\"' --date=relative'
format='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(cyan)<%an>%Creset'
alias glg='git log --graph --pretty=format:'\"$format\"' --date=relative'
alias glgs='git log --pretty=format:'\"$format\"' --date=relative'
###########################

