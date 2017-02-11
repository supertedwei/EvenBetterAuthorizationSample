#! /bin/sh

# <codex>
# <abstract>Script to remove everything installed by the sample.</abstract>
# </codex>

# This uninstalls everything installed by the sample.  It's useful when testing to ensure that 
# you start from scratch.

sudo launchctl unload /Library/LaunchDaemons/com.example.apple-samplecode.NinjaMode.HelperTool.plist
sudo rm /Library/LaunchDaemons/com.example.apple-samplecode.NinjaMode.HelperTool.plist
sudo rm /Library/PrivilegedHelperTools/com.example.apple-samplecode.NinjaMode.HelperTool

sudo security -q authorizationdb remove "com.example.apple-samplecode.NinjaMode.readLicenseKey"
sudo security -q authorizationdb remove "com.example.apple-samplecode.NinjaMode.writeLicenseKey"
sudo security -q authorizationdb remove "com.example.apple-samplecode.NinjaMode.startWebService"

sudo defaults delete com.example.apple-samplecode.NinjaMode.HelperTool licenseKey
