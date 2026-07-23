#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://aur.archlinux.org/cgit/aur.git/plain/epsxe.png?h=epsxe
export DESKTOP=https://aur.archlinux.org/cgit/aur.git/plain/epsxe.desktop\?h\=epsxe
export DEPLOY_OPENGL=1

wget https://raw.githubusercontent.com/Samueru-sama/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh -O /usr/local/bin/quick-sharun
chmod +x /usr/local/bin/quick-sharun

# Deploy dependencies
quick-sharun \
	./epsxe             \
	/usr/lib/libnsl.so* \
	/usr/lib/libnss_compat.so*

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
