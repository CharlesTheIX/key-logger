#!/bin/bash

init() {
  paths=(
    "./bash/build.sh"
  )

  for path in "${paths[@]}"; do
    if [ -e "$path" ]; then
      chmod +x "$path"
    fi
  done
}

init