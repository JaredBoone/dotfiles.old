#!/bin/bash


symlink_binaries() {
  echo "Moving ~/bin to ~/bin_old"
  rm -f ~/bin_old
  mv ~/bin ~/bin_old

  # Copy binaries
  ln -fs $HOME/dotfiles/bin $HOME

  declare -a BINARIES=(
    'set-defaults'
  )

  for i in ${BINARIES[@]}; do
    echo "Doing chmod +rwx ${i##*/}"
    chmod +rwx $HOME/bin/${i##*/}
  done

  unset BINARIES
}

echo "[bin.sh] - Begin"
symlink_binaries
echo "[bin.sh] - End"
