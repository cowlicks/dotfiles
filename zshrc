# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
#crcandy,.

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git autopep8 python tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
export PATH=$PATH:~/bin
# and cargo's binaries
export PATH=$PATH:~/.cargo/bin
# private scripts
source ~/.private

# export MANPATH="/usr/local/man:$MANPATH"

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

# For virtualenv python dev
#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/~/
#source /usr/bin/virtualenvwrapper.sh

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# grep aliases
alias grep='grep --color=auto --exclude-dir={.next,.bzr,CVS,.git,.hg,.svn,.idea,.tox,node_modules,dist,venv,__pycache__,.bak,target} -I --exclude=.eslintcache '

# anaconda install location
#export PATH=/home/blake/anaconda/bin:$PATH

export VISUAL="vim"
export GOPATH=$HOME/go

# docker
alias dcomp="docker-compose"
alias dock="docker"

# The next line updates PATH for the Google Cloud SDK.
GCLOUD_INSTALL_DIR='/home/blake/.google-cloud-sdk'
if [ -f "${GCLOUD_INSTALL_DIR}/path.zsh.inc" ]; then . "${GCLOUD_INSTALL_DIR}/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${GCLOUD_INSTALL_DIR}/completion.zsh.inc" ]; then . "${GCLOUD_INSTALL_DIR}/completion.zsh.inc"; fi

alias vim="nvim"
alias vi="nvim"

# use 'hrep' to search history
alias hrep='history | grep'

# taking notes!
# a note is any command line thing that contains '##'
alias notes="history 1 | grep '##'"

# Set up Node Version Manager
source /usr/share/nvm/init-nvm.sh

# refresh sudo's timeout each time you use it
alias sudo='sudo -v; sudo '
