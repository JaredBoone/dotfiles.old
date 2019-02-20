#!/bin/bash

echo "[langs.sh] - Begin"

export PATH="/usr/local/opt/python/libexec/bin:$PATH"

declare -a PACKAGES=(
 'ansible'
 'molecule'
 'docker-py'
)

for i in ${PACKAGES[@]}; do
  pip install $i
done

echo "[langs.sh] - End"
