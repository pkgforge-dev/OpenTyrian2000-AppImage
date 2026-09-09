#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q opentyrian2000 | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/KScl/opentyrian2000/refs/heads/master/linux/icons/tyrian2000-128.png
export DESKTOP=https://raw.githubusercontent.com/KScl/opentyrian2000/refs/heads/master/linux/opentyrian2000.desktop
export STARTUPWMCLASS=opentyrian2000
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/opentyrian2000
echo 'SHARUN_WORKING_DIR=${SHARUN_DIR}/share/opentyrian2000' >> ./AppDir/.env

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the app normally quits before that time
# then skip this or check if some flag can be passed that makes it stay open
quick-sharun --simple-test ./dist/*.AppImage
