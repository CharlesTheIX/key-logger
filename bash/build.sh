#!/bin/bash

build() {
  pyinstaller --onefile --windowed --name KeyLogger --icon=assets/icon.icns main.py
}

build