#!/bin/bash

install_zsh () {
    echo "[zsh.sh] - Begin"

  # Install zsh
  if [ ! -f /usr/local/bin/zsh ]; then
      echo "Installing zsh. Re-run this script."
      brew install zsh
      exit
  fi

  # Set the default shell to zsh\
  if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
    echo "Setting default shell to zsh. Re-run this script."
    sudo -v
    sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
    sudo chsh -s /usr/local/bin/zsh $USER
  fi

  # Install Oh My Zsh
  if [[ ! -d $HOME/.oh-my-zsh/ ]]; then
    echo "Installing oh-my-zsh. Re-run this script."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    exit
  fi

  # zsh-nvm
  if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-nvm/ ]]; then
    echo "Installing zsh-nvm plugin."
    git clone https://github.com/lukechilds/zsh-nvm $HOME/.oh-my-zsh/custom/plugins/zsh-nvm
  fi

  # Install powerline fonts
  if [[ ! -f "${HOME}/Library/Fonts/Meslo LG M Regular for Powerline.ttf" ]]; then
    cp "${HOME}/dotfiles/iterm/fonts/Meslo LG M Regular for Powerline.ttf" $HOME/Library/Fonts/
  fi
  if [[ ! -f "${HOME}/Library/Fonts/Source Code Pro for Powerline.otf" ]]; then
    cp "${HOME}/dotfiles/iterm/fonts/Source Code Pro for Powerline.otf" $HOME/Library/Fonts/
  fi

  # Install custom zsh theme
  if [[ ! -f $HOME/.oh-my-zsh/themes/jared.zsh-theme ]]; then
    echo "Installing custom theme: jared"
    ln -s ~/dotfiles/zsh/themes/jared.zsh-theme $HOME/.oh-my-zsh/themes
  fi

  # Local zshrc
  touch ${HOME}/.zshrc.local

  echo "[zsh.sh] - End"
}

install_zsh
