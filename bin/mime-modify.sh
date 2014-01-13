#!/bin/sh

plutil -insert CFBundleDocumentTypes -xml '<array><dict><key>CFBundleTypeExtensions</key><array><string>ccla</string></array><key>CFBundleTypeMIMETypes</key><array><string>application/vnd.concordconsortium.launcher</string></array><key>CFBundleTypeName</key><string>CC Launcher Doc</string><key>LSHandlerRank</key><string>Owner</string></dict></array>' dist/app/CCLauncher.app/Contents/Info.plist
