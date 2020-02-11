# Path to your oh-my-zsh installation.
export ZSH=/Users/flove/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="gianu"

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
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

plugins=(git zsh-autosuggestions zsh-completions)

source $ZSH/oh-my-zsh.sh

export EDITOR='zile'
# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


#export PROJECT_HOME=$HOME/Devel
# Pip and Virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PATH="$PATH:/usr/local/opt/python/bin"
export PYTHONDONTWRITEBYTECODE=1
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv


source /usr/local/bin/virtualenvwrapper.sh

# Golang
export PATH=~/.local/bin:$PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export HADOOP_CONF_DIR=/etc/hadoop/conf
export PATH=$PATH:/opt/spark/spark-2.4.2-bin-hadoop2.7/bin
export SPARK_HOME=/opt/spark/spark-2.4.2-bin-hadoop2.7
export PYTHONPATH=$SPARK_HOME/python/:$SPARK_HOME/python/lib/py4j-0.10.3-src.zip:$PYTHONPATH

# Postgres
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

## Aliases
## Show hidden files ##
alias l.='ls -d .* --color=auto'
## get rid of command not found ##
alias cd..='cd ..'

## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'


# for disabling netscope
alias disable-netscope="launchctl unload /Library/LaunchDaemons/com.netskope.stagentsvc.plist"


alias mkdir='mkdir -pv'
export PATH="/usr/local/opt/openssl/bin:$PATH"
# Java 8 for spark
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home"

export XDG_CONFIG_HOME="/Users/flove/.config"

export LDAPRC=$XDG_CONFIG_HOME/ldap.conf
alias ldap="ldapsearch -LLL -o ldif-wrap=no -y $XDG_CONFIG_HOME/ldap.conf -x"

ldap_fields=(department division employeeID givenName mail mobile personalTitle physicalDeliveryOfficeName title wWWHomePage co l st sn lastLogon)

function card() {
    ldap $1 $ldap_fields | ldif2json | jq '
        include "filename";
        .
        | .dn |= (. / "," | map(. / "="))
        | .name = "\(.givenName) \(.sn)"
        | del(.givenName)
        | del(.sn)
        | if .physicalDeliveryOfficeName == .l then
              del(.physicalDeliveryOfficeName)
          else
              .
          end
        | .location = "\(.l), \(.st)" +
            if .co != "United States" then
                ", \(.co)"
            else
                ""
            end
        | del(.l)
        | del(.st)
        | del(.co)
    '
}

function cards() {
    card $1 | jq -c . | selecta | jq
}


