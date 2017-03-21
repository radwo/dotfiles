# Path to your oh-my-zsh configuration.
setopt NO_BEEP

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

ZSH=$HOME/.dotfiles/oh-my-zsh

# specify a theme
export ZSH_THEME="intridea"
export ZSH_CUSTOM=$HOME/.dotfiles/zsh/custom

# Never know when you're gonna need to popd!
setopt AUTO_PUSHD

# Allow completing of the remainder of a command
bindkey "^N" insert-last-word

# Show contents of directory after cd-ing into it
chpwd() {
  ls -lrthG
}

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

export PATH=$HOME/.rbenv/bin:$HOME/bin:$HOME/pear/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/mysql/bin:/usr/bin/mysql:$PATH
export PATH="/usr/local/opt/node@6/bin:$PATH"

# load rbenv
eval "$(rbenv init -)"

# load from the available list of plugins at ~/.oh-my-zsh/plugins
plugins=(bundler git git-flow rails ruby cap brew gem github osx vagrant)

source $ZSH/oh-my-zsh.sh
# source ~/.git-flow-completion.zsh #you have to paste that file to that location then

source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions

# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

export EDITOR=vim

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

# added by travis gem
[ -f ${HOME}/.travis/travis.sh ] && source ${HOME}/.travis/travis.sh

LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
if [ -f $LUNCHY_DIR/lunchy-completion.zsh ]; then
  . $LUNCHY_DIR/lunchy-completion.zsh
fi
[ -f ~/.gnupg/gpg-agent.env ] && source ~/.gnupg/gpg-agent.env
if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
  export GPG_AGENT_INFO
else
  eval $(gpg-agent --daemon --log-file /tmp/gpg.log --write-env-file ~/.gnupg/gpg-agent.env --pinentry-program /usr/local/bin/pinentry-mac)
fi
