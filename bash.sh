#!/bin/bash

set -euo pipefail

os="unknown"
ICON_PATH=""
ENTRY="./main.py"
APP_NAME="KeyLogger"
case "$(uname -s)" in
  Darwin) os="macos" ;;
  Linux) os="linux" ;;
  MINGW*|MSYS*|CYGWIN*|Windows_NT) os="windows" ;;
  *) echo "Unsupported OS: $(uname -s)"; exit 1 ;;
esac

case "$os" in
  macos) ICON_PATH="assets/icon.icns" ;;
  linux) ICON_PATH="assets/icon.png" ;;
  windows) ICON_PATH="assets/icon.ico" ;;
  *) echo "Unsupported OS: $os"; exit 1 ;;
esac

build() {
  if [ ! -f "$ICON_PATH" ]; then
    make_icon
  fi

  if [ ! -f "$ICON_PATH" ]; then
    echo "Icon creation failed: $ICON_PATH not found"; exit 1
  fi

  echo "Building application..."
  pyinstaller --onefile --windowed --name "$APP_NAME" --icon="$ICON_PATH" "$ENTRY"
  echo "Build complete!"
}

clean() {
  echo "Cleaning build artifacts..."
  rm -rf ./venv ./dist ./build ./KeyLogger.spec \
         ./assets/icon.png ./assets/icon.ico ./assets/icon.icns
  echo "Clean complete."
}

handler() {
  if [ $# -eq 0 ]; then
    echo "Usage: $0 {build|clean|install}"; exit 1
  fi

  case "$1" in
    build) build ;;
    clean) clean ;;
    install) install_dependencies ;;
    *) echo "Unknown command: $1"; exit 1 ;;
  esac
}

install_dependencies() {
  local req_file="./requirements/${os}.txt"

  if [ -f "$req_file" ]; then
    echo "Installing dependencies from $req_file..."
    pip install -r "$req_file"
    echo "Dependencies installed."
  else
    echo "No requirements file found for '$os'."; exit 1
  fi
}

make_icon() {
  mkdir -p assets

  ICON_SRC="assets/${os}.png"
  if [ ! -f "$ICON_SRC" ]; then
    echo "Icon source not found: $ICON_SRC"; exit 1
  fi

  case "$os" in
    macos)
      if ! command -v sips &>/dev/null || ! command -v iconutil &>/dev/null; then
        echo "Missing required macOS utilities: 'sips' and/or 'iconutil'"; exit 1
      fi

      ICONSET_DIR="assets/icon.iconset"
      mkdir -p "$ICONSET_DIR"
      sips -z 16 16     "$ICON_SRC" --out "$ICONSET_DIR/icon_16x16.png"
      sips -z 32 32     "$ICON_SRC" --out "$ICONSET_DIR/icon_16x16@2x.png"
      sips -z 32 32     "$ICON_SRC" --out "$ICONSET_DIR/icon_32x32.png"
      sips -z 64 64     "$ICON_SRC" --out "$ICONSET_DIR/icon_32x32@2x.png"
      sips -z 128 128   "$ICON_SRC" --out "$ICONSET_DIR/icon_128x128.png"
      sips -z 256 256   "$ICON_SRC" --out "$ICONSET_DIR/icon_128x128@2x.png"
      sips -z 256 256   "$ICON_SRC" --out "$ICONSET_DIR/icon_256x256.png"
      sips -z 512 512   "$ICON_SRC" --out "$ICONSET_DIR/icon_256x256@2x.png"
      sips -z 512 512   "$ICON_SRC" --out "$ICONSET_DIR/icon_512x512.png"
      cp "$ICON_SRC" "$ICONSET_DIR/icon_512x512@2x.png"
      iconutil -c icns "$ICONSET_DIR" -o assets/icon.icns
      rm -rf "$ICONSET_DIR"
      ICON_PATH="assets/icon.icns"
      ;;
    linux)
      if ! command -v magick &>/dev/null; then
        echo "ImageMagick 'magick' not found."; exit 1
      fi

      magick "$ICON_SRC" -resize 256x256 "$ICON_PATH"
      ;;
    windows)
      if ! command -v magick &>/dev/null; then
        echo "ImageMagick 'magick' not found."; exit 1
      fi

      magick "$ICON_SRC" -define icon:auto-resize=64,128,256 "$ICON_PATH"
      ;;
    *) echo "Unsupported OS: $os"; exit 1 ;;
  esac

  echo "Icon created at: $ICON_PATH"
}

handler "$@"
