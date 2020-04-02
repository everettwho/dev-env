# Path to your oh-my-zsh installation.
export ZSH=/Users/everetthu/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias arggh='npm run lint'
alias argghh='npm run test'

alias g='git'
alias gc='git checkout'
alias gs='git status'
alias gd='git diff'
alias gp='git push'
alias sneaky='git push --no-verify'
alias gpsu='gp --set-upstream origin'
alias gst='git stash'
alias gpl='git pull'
alias gpr='git pull --rebase'
alias gcam='git commit -am'
alias gcd='git checkout develop'
alias gcm='git checkout master'
alias grhh='git reset --hard HEAD'
alias grha='git reset HEAD .'
alias undocomm='git reset --soft HEAD~1'
alias gb='gc -B'
alias gmm='git merge master'
alias gmc='git merge --continue'

alias yi='yarn install --pure-lockfile'
alias yicf='yarn install --check-files'

nsv() {
  npm show "$1" versions --json
}

gpnb() {
  CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD);
  if [[ ${CURRENT_BRANCH} == 'master' ]]; then
    echo "Current branch is master"
  else 
    gcam "$1";
    gpsu --no-verify $CURRENT_BRANCH;
  fi
}

findport() {
  sudo lsof -i tcp:"$1"
}

killport() {
  PID=$(sudo lsof -i tcp:"$1" | grep node | tr -s ' ' | cut -d " " -f 2 | head -n 1 |xargs);
  kill -9 $PID;
  echo 'Killed PID' $PID;
}

export GOPATH=$HOME/go
export PATH=$PATH:$HOME/bin:/usr/local/lib/node_modules:/usr/local/go/bin:$GOPATH/bin
export EDITOR='subl'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


function cookbook() {
  NPM_ROOT=$(npm root -g) && node $NPM_ROOT/@dydxprotocol/cookbook/build/index.js "$@"
}

function deploysolo() {
  cookbook deploy solo-web "$@" production
}

function https_certs() {
   sudo openssl genrsa -out ~/.localhost-ssl/localhost.key 2048;
   sudo openssl req -new -x509 -key ~/.localhost-ssl/localhost.key -out ~/.localhost-ssl/localhost.crt -days 3650 -subj /CN=localhost;
   sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ~/.localhost-ssl/localhost.crt;
}
