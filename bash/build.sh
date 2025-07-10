#!/bin/bash

source "$(dirname "$0")/utils.sh"
source "$(dirname "$0")/make_icon.sh"

build() {
  os=$(get_os)
  APP_NAME="KeyLogger"
  ENTRY="main.py"
  ICON_PATH=""

  case "$os" in
    macos)
      ICON_PATH="assets/icon.icns"
      ;;
    linux)
      ICON_PATH="assets/icon.png"
      ;;
    windows)
      ICON_PATH="assets/icon.ico"
      ;;
    *)
      echo "Unsupported OS: $(uname -s)"
      exit 1
      ;;
  esac

  if [ ! -f "$ICON_PATH" ]; then
    make_icon

    if [ ! -f "$ICON_PATH" ]; then
      echo "Icon file not found: $ICON_PATH"
      exit 1
    fi
  fi
  

  echo "Building $APP_NAME using PyInstaller..."
  pyinstaller --onefile --windowed --name "$APP_NAME" --icon="$ICON_PATH" "$ENTRY"
  echo "Build complete!"
}

build