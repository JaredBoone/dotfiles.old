# Jared Boone's Dotfiles

Clone to your home directory in `~/dotfiles/` and run the install script to create symlinks.

The install script will ... 
- backup ~/dotfiles to ~/dotfiles_old
- create symlinks 
- install oh-my-zsh
- install zsh and make it the default shell
- install a custom zsh theme 
- set some macos defaults

## Install

```sh
$ cd
$ git clone https://github.com/JaredBoone/dotfiles.git
$ cd ~/dotfiles
$ . ./install.sh
```

## Customize

The dotfiles can be extended locally:
#### `~/.zsh.local`
#### `~/.gitconfig.local`
