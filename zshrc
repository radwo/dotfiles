# Path to your oh-my-zsh configuration.
ZSH=$HOME/.dotfiles/oh-my-zsh

# specify a theme
export ZSH_THEME="robbyrussell"

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

# load RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# load from the available list of plugins at ~/.oh-my-zsh/plugins
plugins=(bundler git git-flow rails ruby cap brew gem github osx vagrant)

source $ZSH/oh-my-zsh.sh
# source ~/.git-flow-completion.zsh #you have to paste that file to that location then

source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions

export PATH=$HOME/pear/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/mysql/bin:/usr/bin/mysql

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Shaves about 0.5s off Rails boot time (when using perf patch). Taken from https://gist.github.com/1688857
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000

# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef
