export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=/home/fenimore/.oh-my-zsh
ZSH_THEME="gentoo"
DISABLE_AUTO_UPDATE="true"
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='emacs -nw'
else
    export EDITOR='emacs -nw'
fi
export SSH_KEY_PATH="~/.ssh/rsa_id"
# or wget
# sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# TO Install
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
