#!/bin/bash

clean() {
    local paths=(
    "./dist"
    "./build"
    "./KeyLogger.spec"
    "./assets/icon.png"
    "./assets/icon.ico"
    "./assets/icon.icns"
  )

  for path in "${paths[@]}"; do
    rm -rf "$path"
  done
}

clean