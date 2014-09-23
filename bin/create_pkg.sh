#!/bin/bash

# This is based on the instructions here:
# http://thegreyblog.blogspot.com/2014/06/os-x-creating-packages-from-command_2.html

SIGN_CERT="Developer ID Installer: Concord Consortium Inc (T8HS8WBPPQ)"
VERSION="1.0.20140917"

mv dist/app/CCLauncher.app dist/pkg/
cp resources/dist.plist tmp/
rm dist/app/Applications

# pkgbuild --sign "$SIGN_CERT" \
#          --component dist/pkg/CCLauncher.app \
#          --identifier org.concord.cclauncher.pkg \
#          --version $VERSION \
#          --install-location /Applications \
#          tmp/CCLauncher.pkg
pkgbuild --sign "$SIGN_CERT" \
         --root dist/pkg \
         --component-plist resources/CCLauncher.plist \
         --identifier org.concord.cclauncher.pkg \
         --version $VERSION \
         --install-location /Applications \
         tmp/CCLauncher.pkg
productbuild --sign "$SIGN_CERT" \
             --distribution tmp/dist.plist \
             --package-path tmp \
             --identifier org.concord.cclauncherinstaller.pkg \
             --version $VERSION \
             dist/app/CCLauncherInstaller.pkg
