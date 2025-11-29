#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm pipewire-audio pipewire-jack nghttp2 libidn libssh2 libpsl openssl krb5 zlib

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
make-aur-package libcurl-compat
make-aur-package epsxe

# If the application needs to be manually built that has to be done down here
