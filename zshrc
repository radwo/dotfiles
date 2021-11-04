# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt NO_BEEP

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# specify a theme
export ZSH_THEME="powerlevel10k/powerlevel10k"

# Never know when you're gonna need to popd!
setopt AUTO_PUSHD

# Allow completing of the remainder of a command
bindkey "^N" insert-last-word

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000


export PATH=$HOME/bin:$HOME/pear/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$PATH

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities github_rsa

# load from the available list of plugins at ~/.oh-my-zsh/plugins
plugins=(asdf dash fzf git gcloud gpg-agent kubectl mix-fast osx safe-paste ssh-agent zsh-interactive-cd)

source $ZSH/oh-my-zsh.sh

source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions

function zvm_before_init() {
  zvm_bindkey viins '^[[A' up-line-or-beginning-search
  zvm_bindkey viins '^[[B' down-line-or-beginning-search
  zvm_bindkey vicmd '^[[A' up-line-or-beginning-search
  zvm_bindkey vicmd '^[[B' down-line-or-beginning-search
}

source $HOME/.dotfiles/zsh/custom/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

export EDITOR=vim

# Fast switch to vi mode
export KEYTIMEOUT=1


[ -f ~/.gnupg/gpg-agent.env ] && source ~/.gnupg/gpg-agent.env
if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
  export GPG_AGENT_INFO
else
  eval $(gpg-agent --daemon --log-file /tmp/gpg.log --write-env-file ~/.gnupg/gpg-agent.env --pinentry-program /usr/local/bin/pinentry-mac)
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
