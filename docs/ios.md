# Building iOS locally

iOS apps cannot be compiled on Linux. You need a macOS machine (physical,
macOS VM, or hosted Mac such as GitHub Actions `macos-latest`,
Codemagic, or Bitrise).

## Prerequisites on macOS

1. **Xcode** (latest stable) from the Mac App Store, plus command-line tools:

   ```bash
   sudo xcode-select --install
   sudo xcodebuild -runFirstLaunch
   ```

2. **CocoaPods** (Flutter iOS uses it for plugins):

   ```bash
   sudo gem install cocoapods
   ```

3. **Flutter SDK 3.50.1** — https://docs.flutter.dev/get-started/install/macos
4. For installing on a real device / TestFlight / App Store:
   - Apple Developer Program membership (https://developer.apple.com/programs/)
   - A signing certificate and provisioning profile in your Xcode account
   - A physical iOS device registered in your developer account

## Verify

```bash
flutter doctor -v
```

Xcode and CocoaPods should show check marks.

## Build unsigned (simulator / verification only)

```bash
cd path/to/platform_showcase
flutter pub get
flutter analyze
flutter build ios --release --no-codesign
```

Output: `build/ios/iphoneos/Runner.app`

> Unsigned builds cannot be installed on a physical device or uploaded to
> TestFlight. They are useful only for checking that the project compiles.

## Build signed (device / TestFlight / App Store)

1. Open `ios/Runner.xcworkspace` in Xcode.
2. Select **Runner** target → **Signing & Capabilities** → choose your Team.
3. Then run:

   ```bash
   flutter build ipa --release \
     --export-options-plist=ios/ExportOptions.plist
   ```

   Output: `build/ios/ipa/*.ipa`

4. Upload with Xcode **Transporter**, or use `xcrun altool`, Codemagic, or Bitrise.

## Notes

- The GitHub Actions workflow uses `--no-codesign`; use Codemagic/Bitrise
  (see `codemagic.yaml` / `bitrise.yml`) or a local Mac with signing for
  distributable builds.
- Keep the iOS deployment target in `ios/Flutter/AppFrameworkInfo.plist`
  compatible with your Flutter version.
