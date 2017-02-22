#Initialize
source "${HOME}/cli-conf/.boot"

#Theme
ZSH_THEME="gallifrey"

#Using case-sensitive completion
CASE_SENSITIVE="true"

#Display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

#Hack to make VCS status checking faster
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Plugins to load for zsh
if [[ "$(uname)" == "Darwin" ]]; then
  plugins=(git aws composer wd osx sudo brew vim pass git-extras ssh-agent vagrant)
else
  plugins=(git aws composer wd sudo vim pass debian git-extras ssh-agent vagrant)
fi

HIST_STAMPS="dd.mm.yyyy"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='vim'
fi

#Load the oh-my-zsh config
source "${ZSH}/oh-my-zsh.sh"
export PATH="/usr/local/sbin:$PATH"
