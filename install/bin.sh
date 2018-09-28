#!/bin/bash


symlink_binaries() {
  
  # check for existing dir
  if [[ -e "$HOME/bin" ]]
  then
    echo "Found exising ~/bin"
    if [[ -L "$HOME/bin" ]]
    then
      # remove old symlink
      echo "Removing stale ~/bin symlink"
      rm -f $HOME/bin
    else
      # backup old bin dir
      now=$(date +"%Y_%m_%d")
      echo "Renaming existing ~/bin to ~/bin.$now"
      mv $HOME/bin $HOME/bin.$now
    fi
  fi

  # create ~/bin symlink
  echo "Creating new ~/bin symlink"
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
