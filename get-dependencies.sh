#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm pipewire-audio pipewire-jack patchelf unzip

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
make-aur-package --chaotic-aur libcurl-compat
make-aur-package --chaotic-aur ncurses5-compat-libs

echo "Getting epsxe binary..."
echo "---------------------------------------------------------------"
BINARY=$(wget --retry-connrefused --tries=30 https://www.epsxe.com/download.php -O - \
  | sed 's/[()",{} ]/\n/g' | grep -oi "https.*linux.*x64.*zip$" | head -1)
wget --retry-connrefused --tries=30 "$BINARY"
unzip ./*.zip
chmod +x ./epsxe_x64
mv -v ./epsxe_x64 ./epsxe

# this app needs an older version of libcurl to work
patchelf --replace-needed libcurl.so.4 libcurl-compat.so.4.8.0 ./epsxe

./epsxe -v | awk 'END {print $NF}' > ~/version

