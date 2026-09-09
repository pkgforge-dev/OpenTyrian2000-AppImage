#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/local/share/icons/hicolor/128x128/apps/opentyrian2000.png
export DESKTOP=/usr/local/share/applications/opentyrian2000.desktop
export STARTUPWMCLASS=opentyrian2000
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/local/bin/opentyrian2000
echo 'SHARUN_WORKING_DIR=${SHARUN_DIR}/share/opentyrian2000' >> ./AppDir/.env

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the app normally quits before that time
# then skip this or check if some flag can be passed that makes it stay open
quick-sharun --simple-test ./dist/*.AppImage
