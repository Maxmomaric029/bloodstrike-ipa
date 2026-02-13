name: Build IPA

on:
  push:
    branches: [ "main" ]
  workflow_dispatch:

jobs:
  build:
    runs-on: macos-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Files
        run: |
          find . -name "main.swift" -exec cp {} . \;
          find . -name "index.html" -exec cp {} . \;
          find . -name "style.css" -exec cp {} . \;
          find . -name "script.js" -exec cp {} . \;
          find . -name "manifest.json" -exec cp {} . \;

      - name: Build App
        run: |
          mkdir -p BloodieHub.app
          cp index.html style.css script.js manifest.json BloodieHub.app/
          xcrun -sdk iphoneos swiftc main.swift -target arm64-apple-ios14.0 -sdk $(xcrun --sdk iphoneos --show-sdk-path) -o BloodieHub.app/BloodieHub -emit-executable

      - name: Info
        run: |
          cat <<EOF > BloodieHub.app/Info.plist
          <?xml version="1.0" encoding="UTF-8"?>
          <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
          <plist version="1.0">
          <dict>
              <key>CFBundleExecutable</key>
              <string>BloodieHub</string>
              <key>CFBundleIdentifier</key>
              <string>com.bloodie.hub</string>
              <key>CFBundleName</key>
              <string>BloodieHub</string>
              <key>CFBundlePackageType</key>
              <string>APPL</string>
              <key>CFBundleShortVersionString</key>
              <string>1.0</string>
              <key>CFBundleVersion</key>
              <string>1</string>
              <key>LSRequiresIPhoneOS</key>
              <true/>
          </dict>
          </plist>
          EOF

      - name: Pack
        run: |
          mkdir Payload
          cp -r BloodieHub.app Payload/
          zip -r BloodieHub.ipa Payload

      - name: Upload
        uses: actions/upload-artifact@v4
        with:
          name: Bloodie-Final-IPA
          path: BloodieHub.ipa
