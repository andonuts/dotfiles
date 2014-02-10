echo "Starting up the shell enviroment (zsh version $ZSH_VERSION)"

# Framework for OS detection
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
   platform='appleunix'
elif [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
fi

if [[ $platform == 'unknown' ]]; then
   echo 'OS detection could not determine your OS!'
   echo 'Some features (or portions thereof) defined in'
   echo 'the .zshrc file may not function.'
else
   echo "Your OS was succesfully detected as $platform."
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="af-magic"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
if [[ $platform == 'appleunix' ]]; then
    plugins=(git virtualenv)
elif [[ $platform == 'linux' ]]; then
    plugins=(git virtualenv)
fi

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/lib64/ccache:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/home/jeff/.local/bin:/home/jeff/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='nano'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# # Functions

function cd() {
    builtin cd "$*" && ls
}

function smart() {
    if [ -n "$1" ]; then
	if [ -z "$2" ]; then
	    /usr/local/sbin/smartctl -s on /dev/$1 > /dev/null
	    /usr/local/sbin/smartctl -A /dev/$1
	else
	    echo "smart: too many arguements."
	fi
    else
	if [[ $platform == 'appleunix' ]]; then
	    echo "smart usage: smart disk#"
	elif [[ $platform == 'linux' ]]; then
	    echo "smart usage: smart sdx"
	fi
    fi
}

function status() {
    echo -e "\033[1mUptime & load average:\033[0m `uptime | sed 's/^..........//' | sed 's/, .* users, load averages: / - /g'`"
    if [[ $platform == 'appleunix' ]]; then
	echo -e "\033[1mBattery status:\033[0m `pmset -g ps | grep "%" | sed s/"-InternalBattery-0"/""/g | tr '\t' '\b' | sed 's/;/ -/g'`"
    elif [[ $platform == 'linux' ]]; then
	echo -e "Battery status not yet implemented for Linux."
    fi
}

#functions or other commands to be run before the user is given a prompt
sleep 1
clear
status
