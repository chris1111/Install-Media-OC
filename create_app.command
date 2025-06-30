#!/bin/bash
# Install Media OC Packager
# This will create a Apple Bundle App Create Install Media HP Laptop 
# Install Media HP Laptop OC Copyright (c) 2020, 2025 chris1111 All rights reserved.
# No right on OpenCore Bootloader
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
# Dependencies: osacompile
PARENTDIR=$(dirname "$0")
cd "$PARENTDIR"
find . -name '.DS_Store' -type f -delete

echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "
echo "Install Media OC Installer "
echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "
Sleep 1
# Declare some VARS
APP_NAME="Install Media OC.app"
SOURCE_SCRIPT="Install-Media-OC.applescript"
rm -rf "$APP_NAME"
rm -rf ./InstallMedia/Installer
rm -rf ./OpenCorePackage/BUILD-PACKAGE
Sleep 1
mkdir -p ./InstallMedia/Installer
mkdir -p ./OpenCorePackage/BUILD-PACKAGE
mkdir -p /tmp/Package-DIR

# Create the Packages with pkgbuild
echo "
= = = = = = = = = = = = = = = = = = = = = = = = =
Create the first Packages with pkgbuild "
pkgbuild --root ./OpenCorePackage/OC-EFI --scripts ./OpenCorePackage/ScriptEFI --identifier com.opencorePackage.OpenCorePackage.pkg --version 1.0 --install-location /Private/tmp/EFIROOTDIR ./OpenCorePackage/BUILD-PACKAGE/opencorePackage.pkg
Sleep 2

# Copy resources and distribution
cp -rp ./OpenCorePackage/Distribution ./OpenCorePackage/BUILD-PACKAGE/Distribution.xml
cp -rp ./OpenCorePackage/Resources ./OpenCorePackage/BUILD-PACKAGE/

# Build the final Packages with Productbuild
echo "
= = = = = = = = = = = = = = = = = = = = = = = = =
Create the finale Packages with productbuild "
Sleep 2
productbuild --distribution "./OpenCorePackage/BUILD-PACKAGE/Distribution.xml"  \
--package-path "./OpenCorePackage/BUILD-PACKAGE/" \
--resources "./OpenCorePackage/BUILD-PACKAGE/Resources" \
"./InstallMedia/Installer/OpenCoreUSB.pkg"
Sleep 1
echo "
= = = = = = = = = = = = = = = = = = = = = = = = =
Create Install Media OC App"
# Create the dir structure
dir=$(cd $(dirname "$1"); pwd)
/usr/bin/osacompile -o "$APP_NAME" "$SOURCE_SCRIPT"
# Use Startup screen, LSUIElement
defaults write "$dir/$APP_NAME"/Contents/Info LSUIElement -bool true
defaults write "$dir/$APP_NAME"/Contents/Info OSAAppletShowStartupScreen -bool true
# Copy applet.icns to the right place
cp -rp ./InstallMedia/applet.icns "$APP_NAME"/Contents/Resources
# Copy description to the right place
cp -rp ./InstallMedia/description.rtfd "$APP_NAME"/Contents/Resources
# Copy Installer to the right place
cp -rp ./InstallMedia/Installer "$APP_NAME"/Contents/Resources
# Copy main.rtf to the right place
cp -rp ./InstallMedia/Scripts/main.rtf "$APP_NAME"/Contents/Resources/Scripts
# Zip app
Sleep 1
zip -r "$APP_NAME".zip "$APP_NAME"
Sleep 1
rm -rf "$APP_NAME"
unzip "$APP_NAME".zip
Sleep 1
rm -rf "$APP_NAME".zip
echo " "
sleep 1
rm -rf ./InstallMedia/Installer
rm -rf ./OpenCorePackage/BUILD-PACKAGE
echo "
= = = = = = = = = = = = = = = = = = = = = = = = = 
Install Media OC.app completed Done!
= = = = = = = = = = = = = = = = = = = = = = = = =  "

