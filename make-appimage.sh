#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(cat ~/version)
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://aur.archlinux.org/cgit/aur.git/plain/epsxe.png?h=epsxe
export DESKTOP=https://aur.archlinux.org/cgit/aur.git/plain/epsxe.desktop\?h\=epsxe
export DEPLOY_OPENGL=1
export DEPLOY_PIPEWIRE=1

# Deploy dependencies
quick-sharun \
	./epsxe             \
	/usr/lib/libnsl.so* \
	/usr/lib/libnss_compat.so*

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
