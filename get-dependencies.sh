#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm hicolor-icon-theme sdl2_net

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

# Comment this out if you need an AUR package
#make-aur-package opentyrian2000

# If the application needs to be manually built that has to be done down here
echo "Building OpenTyrian2000..."
echo "---------------------------------------------------------------"
REPO="https://github.com/KScl/opentyrian2000"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --depth 1 "$REPO" ./opentyrian2000
echo "$VERSION" > ~/version

mkdir -p /usr/share/opentyrian2000
wget https://camanis.net/tyrian/tyrian2000.zip
bsdtar -xvf ./tyrian2000.zip \
  -C /usr/share/opentyrian2000 \
  -s '/^tyrian2000\///' \
  'tyrian2000/*.dat' 'tyrian2000/*.lvl' 'tyrian2000/*.shp' 'tyrian2000/*.snd' \
  'tyrian2000/demo.*' 'tyrian2000/music.mus' 'tyrian2000/tyrend.anm' \
  'tyrian2000/tyrian.cdt' 'tyrian2000/tyrian.hdt' 'tyrian2000/tyrian.pic' \
  'tyrian2000/tshp2.pcx'
cd ./opentyrian2000
make prefix=/usr gamesdir=/usr/share all -j$(nproc)
make install
