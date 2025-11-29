#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q epsxe | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=PATH_OR_URL_TO_ICON
export DESKTOP=PATH_OR_URL_TO_DESKTOP_ENTRY
export DEPLOY_OPENGL=1
export DEPLOY_PIPEWIRE=1
export PATH_MAPPING='/opt/epsxe:${SHARUN_DIR}'

# Deploy dependencies
quick-sharun /opt/epsxe/*

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
