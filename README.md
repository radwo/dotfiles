# Radosław Woźniak's dot files

## Installation

```
git clone git://github.com/crashh/dotfiles ~/.dotfiles
cd ~/.dotfiles

git submodule update --init --recursive

rake install
```  
  

Vim plugins are managed through vundle. You'll need to install vundle to get them.

```
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
```
And in vim run
```
:BundleInstall.
```
