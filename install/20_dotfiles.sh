#!/bin/bash

# Symlink dotfiles to ~/

answer_is_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]] \
    && return 0 \
    || return 1
}

ask_for_confirmation() {
  print_question "$1 (y/n) "
  read -n 1
  printf "\n"
}

execute() {
  $1 &> /dev/null
  print_result $? "${2:-$1}"
}

print_error() {
  # Print output in red
  printf "\e[0;31m  [✖] $1 $2\e[0m\n"
}

print_question() {
  # Print output in yellow
  printf "\e[0;33m  [?] $1\e[0m"
}

print_result() {
  [ $1 -eq 0 ] \
    && print_success "$2" \
    || print_error "$2"

  [ "$3" == "true" ] && [ $1 -ne 0 ] \
    && exit
}

print_success() {
  # Print output in green
  printf "\e[0;32m  [✔] $1\e[0m\n"
}

symlink_dotfiles() {

  # dotfiles directory
  dir=~/dotfiles

  local i=''
  local sourceFile=''
  local targetFile=''

  declare -a FILES_TO_SYMLINK=(
    'shell/bash_profile'
    'shell/zshrc'
    'git/gitconfig'
    'git/gitignore'
  )

  # Create dotfiles backup in homedir
  now=$(date +"%Y_%m_%d")
  echo "Creating ~/dotfiles.$now"
  mkdir -p $HOME/dotfiles.$now
  echo "Done"

  for i in ${FILES_TO_SYMLINK[@]}; do
    echo "Moving existing dotfiles from ~ to ~/dotfiles.$now/"
    mv $HOME/.${i##*/} $HOME/dotfiles.$now/
  done


  # Change to the dotfiles directory
  echo "Changing to the $dir directory..."
  pushd $dir
  echo "Done"

  for i in ${FILES_TO_SYMLINK[@]}; do

    sourceFile="$(pwd)/$i"
    targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

    if [ ! -e "$targetFile" ]; then
      execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
    elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
      print_success "$targetFile → $sourceFile"
    else
      ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
      if answer_is_yes; then
        rm -rf "$targetFile"
        execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
      else
        print_error "$targetFile → $sourceFile"
      fi
    fi

  done

  popd

  unset FILES_TO_SYMLINK

}
echo "[dotfiles.sh] - Begin"
symlink_dotfiles
echo "[dotfiles.sh] - End"
