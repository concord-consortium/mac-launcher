mac-launcher
============

This project creates the launcher app needed for OS X machines running 10.9 (Mavericks) or newer.

It gets around the need to sign your jnlp by providing a signed app which launches a custom .ccla file (application/vnd.concordconsortium.launcher mime-type). A .ccla file is basically a renamed jnlp. It uses the Java Client Launcher to bootstrap an embedded JRE and download/launch a jnlp.

## Building

Building the app and .dmg is only supported on Mac. You will need Apache Ant.

1. Export JAVA_HOME to point to the main directory for the JDK/JRE you want to bundle in the app. ``export JAVA_HOME=`/usr/libexec/java_home` `` is a sensible starting place.
1. Run `ant package` to generate a full .dmg, or `ant build` to only build the .app
1. The .dmg will be `dist/cc_launcher_install.dmg`, and the app will be `dist/app/CCLauncher.app`
