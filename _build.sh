#!/bin/bash

get_os() {
  case "$(uname -s)" in
    Darwin) echo "macos" ;;
    Linux) echo "linux" ;;
    MINGW*|MSYS*|CYGWIN*|Windows_NT) echo "windows" ;;
    *) echo "unknown" ;;
  esac
}

os=$(get_os)
ICON_PATH=""
ENTRY="./main.py"
APP_NAME="KeyLogger"

case "$os" in
  macos) ICON_PATH="assets/icon.icns" ;;
  linux) ICON_PATH="assets/icon.png" ;;
  windows) ICON_PATH="assets/icon.ico" ;;
  *)
    echo "Unsupported OS."
    exit 1
    ;;
esac

make_icon() {
  case "$os" in
    macos)
      if ! command -v sips &> /dev/null || ! command -v iconutil &> /dev/null; then
        echo "Required macOS utilities 'sips' or 'iconutil' are missing."
        exit 1
      fi

      ICON_SRC="assets/mac_icon.png"
      if [ ! -f "$ICON_SRC" ]; then
        echo "Icon source file not found: $ICON_SRC"
        exit 1
      fi

      mkdir -p assets/icon.iconset
      sips -z 16 16     "$ICON_SRC" --out assets/icon.iconset/icon_16x16.png
      sips -z 32 32     "$ICON_SRC" --out assets/icon.iconset/icon_16x16@2x.png
      sips -z 32 32     "$ICON_SRC" --out assets/icon.iconset/icon_32x32.png
      sips -z 64 64     "$ICON_SRC" --out assets/icon.iconset/icon_32x32@2x.png
      sips -z 128 128   "$ICON_SRC" --out assets/icon.iconset/icon_128x128.png
      sips -z 256 256   "$ICON_SRC" --out assets/icon.iconset/icon_128x128@2x.png
      sips -z 256 256   "$ICON_SRC" --out assets/icon.iconset/icon_256x256.png
      sips -z 512 512   "$ICON_SRC" --out assets/icon.iconset/icon_256x256@2x.png
      sips -z 512 512   "$ICON_SRC" --out assets/icon.iconset/icon_512x512.png
      cp "$ICON_SRC" assets/icon.iconset/icon_512x512@2x.png
      iconutil -c icns assets/icon.iconset -o assets/icon.icns
      rm -rf assets/icon.iconset
      ICON_PATH="assets/icon.icns"
      ;;
    linux)
      if ! command -v magick &> /dev/null; then
        echo "ImageMagick 'magick' command not found. Please install ImageMagick."
        exit 1
      fi

      ICON_SRC="assets/linux_icon.png"
      if [ ! -f "$ICON_SRC" ]; then
        echo "Icon source file not found: $ICON_SRC"
        exit 1
      fi

      magick "$ICON_SRC" -resize 256x256 assets/icon.png
      ICON_PATH="assets/icon.png"
      ;;
    windows)
      if ! command -v magick &> /dev/null; then
        echo "ImageMagick 'magick' command not found. Please install ImageMagick."
        exit 1
      fi

      ICON_SRC="assets/windows_icon.png"
      if [ ! -f "$ICON_SRC" ]; then
        echo "Icon source file not found: $ICON_SRC"
        exit 1
      fi

      magick "$ICON_SRC" -define icon:auto-resize=64,128,256 assets/icon.ico
      ICON_PATH="assets/icon.ico"
      ;;
    *)
      echo "Unsupported OS."
      exit 1
      ;;
  esac
  echo "Created icon: $ICON_PATH"
}

build() {
  if [ ! -f "$ICON_PATH" ]; then
    make_icon

    if [ ! -f "$ICON_PATH" ]; then
      echo "Icon file not found: $ICON_PATH"
      exit 1
    fi
  fi

  pyinstaller --onefile --windowed --name "$APP_NAME" --icon="$ICON_PATH" "$ENTRY"
  echo "Build complete!"
}

build
