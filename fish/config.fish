alias ll='exa -alF --git'
alias lt='ll --tree --level 2'

alias rc='source ~/.bashrc'
alias q='exit'
alias cat='bat'

#alias br='br -hg'

# vim
alias svim='sudo vim'
alias vbrc='vim ~/.bashrc'
alias vbal='vim ~/.bash_aliases'
alias vfrc='vim ~/.config/fish/config.fish'
alias vfvar='vim ~/.config/fish/fish_variables'
##############################

# pacman
alias pmupd='sudo pacman -Syu'
alias pminst='sudo pacman -S'
alias pmrm='sudo pacman -D'

# tmux
alias tx='tmux'
alias txls='tmux ls'
alias txr='tmux attach-session -t'
alias txn='tmux new -s'
alias gtxk='tmux kill-session -t'
##############################

# custom git alias
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

function newBranchWithRemote
    git checkout -b $1
    git push -u origin HEAD
end

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


# install starship
starship init fish | source

# expose gitlab home
export GITLAB_HOME=/srv/gitlab
