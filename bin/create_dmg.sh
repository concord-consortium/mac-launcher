#!/bin/bash

# This is based on the instructions here:
# http://stackoverflow.com/questions/96882/how-do-i-create-a-nice-looking-dmg-for-mac-os-x-using-command-line-tools

OUT_DMG="dist/cc_launcher_installer.dmg"

hdiutil create -srcfolder "dist/app" -volname "CC Launcher Installer" -fs HFS+ -fsargs "-c c=64,a=16,e=16" -format UDRW -size 160M dist/cc_launcher_installer.tmp.dmg

LOC=$(hdiutil attach -readwrite -noverify -noautoopen "dist/cc_launcher_installer.tmp.dmg" | egrep '^/dev/' | sed 1q | awk '{print $1}')

sleep 15

if [ -e dist/app/Applications ]; then
  echo '
     tell application "Finder"
       tell disk "CC Launcher Installer"
             open
             set current view of container window to icon view
             set toolbar visible of container window to false
             set statusbar visible of container window to false
             set the bounds of container window to {400, 100, 900, 412}
             set theViewOptions to the icon view options of container window
             set icon size of theViewOptions to 150
             set arrangement of theViewOptions to not arranged
             set background picture of theViewOptions to file ".background:bg.png"
             set position of item "CCLauncher.app" of container window to {100, 100}
             set position of item "Applications" of container window to {375, 100}
             update without registering applications
             close
             open
             delay 5
       end tell
     end tell
  ' | osascript
else
  OUT_DMG="dist/cc_launcher_installer_pkg.dmg"
  echo '
     tell application "Finder"
       tell disk "CC Launcher Installer"
             open
             set current view of container window to icon view
             set toolbar visible of container window to false
             set statusbar visible of container window to false
             set the bounds of container window to {400, 100, 900, 412}
             set theViewOptions to the icon view options of container window
             set icon size of theViewOptions to 150
             set arrangement of theViewOptions to not arranged
             set background picture of theViewOptions to file ".background:bg.png"
             set position of item "CCLauncherInstaller.pkg" of container window to {250, 100}
             update without registering applications
             close
             open
             delay 5
       end tell
     end tell
  ' | osascript
fi

chmod -Rf go-w "/Volumes/CC Launcher Installer"
sync
sync
hdiutil detach ${LOC}
sleep 5
hdiutil convert "dist/cc_launcher_installer.tmp.dmg" -format UDZO -imagekey zlib-level=9 -o "$OUT_DMG"
rm -f dist/cc_launcher_installer.tmp.dmg
