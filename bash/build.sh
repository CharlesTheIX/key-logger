#!/bin/bash

get_os() {
  case "$(uname -s)" in
    Darwin)
      echo "macos"
      ;;
    Linux)
      echo "linux"
      ;;
    MINGW*|MSYS*|CYGWIN*|Windows_NT)
      echo "windows"
      ;;
    *)
      echo "unknown"
      ;;
  esac
}

make_icon() {
  os=$(get_os)

  case "$os" in
    macos)
      ICON_SRC="assets/mac_icon.png"
      echo "Creating .icns for macOS..."
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
      echo "Created macOS icon: assets/icon.icns"
      ;;

    linux)
      ICON_SRC="assets/linux_icon.png"
      echo "Creating PNG icon for Linux..."
      if ! command -v magick &> /dev/null; then
        echo "ImageMagick 'magick' command not found. Please install ImageMagick."
        exit 1
      fi
      magick "$ICON_SRC" -resize 256x256 assets/icon.png
      echo "Created Linux icon: assets/icon.png"
      ;;

    windows)
      ICON_SRC="assets/windows_icon.png"
      echo "Creating .ico for Windows..."
      if ! command -v magick &> /dev/null; then
        echo "ImageMagick 'magick' command not found. Please install ImageMagick."
        exit 1
      fi
      magick "$ICON_SRC" -define icon:auto-resize=64,128,256 assets/icon.ico
      echo "Created Windows icon: assets/icon.ico"
      ;;

    *)
      echo "Unsupported OS: $(uname -s)"
      exit 1
      ;;
  esac
}

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