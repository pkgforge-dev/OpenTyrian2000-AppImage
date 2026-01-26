#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q opentyrian2000 | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/128x128/apps/opentyrian2000.png
export DESKTOP=/usr/share/applications/opentyrian2000.desktop
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/opentyrian2000
cp /usr/share/opentyrian2000/* ./AppDir/bin

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
