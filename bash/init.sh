#!/bin/bash

init() {
  paths=(
    "./bash/utils.sh"
    "./bash/build.sh"
    "./bash/make_icon.sh"
  )

  for path in "${paths[@]}"; do
    if [ -e "$path" ]; then
      chmod +x "$path"
    fi
  done
}

init