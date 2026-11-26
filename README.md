# Platform Showcase

A single Flutter/Dart codebase that targets **Android, iOS, Web, Windows,
macOS, and Linux**. This project was scaffolded with all six platform folders:

```
flutter create \
  --platforms=android,ios,web,windows,macos,linux \
  --org=com.example --project-name=platform_showcase .
```

The demo app displays the current platform, a working counter (state survives
hot reload), and chips for every supported target.

## Tool / target status on this Linux host

| Target | Buildable here? | How |
|---|---|---|
| Web | Yes | `flutter build web --release` — verified |
| Linux desktop | Yes | Root-free local toolchain via `source ./setup_env.sh` — verified |
| Android | Yes | Existing SDK at `~/Android/Sdk` + `setup_env.sh` — build in progress/verified |
| Windows desktop | No (needs Windows + Visual Studio) | GitHub Actions / Codemagic / Bitrise / local Windows (see `docs/windows.md`) |
| iOS | No (needs macOS + Xcode) | GitHub Actions unsigned / Codemagic / Bitrise / local Mac (see `docs/ios.md`) |
| macOS desktop | No (needs macOS + Xcode) | Same macOS routes as iOS |

Flutter version: **3.50.1** (stable), Dart **3.14.0**.

`flutter doctor` result after setup: all categories green except the harmless
duplicate-`adb` warning.

## First-time setup on this machine

```bash
cd ~/Documents/Default\ Project/cross_platform_demo
source ./setup_env.sh       # also auto-sourced from ~/.bashrc in new shells
flutter doctor
flutter pub get
flutter test
```

`setup_env.sh` adds:

- Android SDK env vars (`ANDROID_HOME`, `ANDROID_SDK_ROOT`)
- local `clang`/`clang++`, `cmake`, `ninja` wrappers in `~/.local/bin`
- a root-free GTK3 dev sysroot in `~/.local/sysroot` with corrected pkg-config files

Details: `docs/linux-toolchain.md`.

## Build commands

```bash
# Web
flutter build web --release
# output: build/web

# Linux desktop
flutter build linux --release
# output: build/linux/x64/release/bundle

# Android APK
flutter build apk --release
# output: build/app/outputs/flutter-apk/app-release.apk

# iOS (on macOS only)
flutter build ios --release --no-codesign
flutter build ipa --release --export-options-plist=ios/ExportOptions.plist

# Windows (on Windows only)
flutter build windows --release
```

## CI / remote build options (all three configured)

1. **GitHub Actions** — `.github/workflows/`
   - `build-android-web.yml` (ubuntu-latest)
   - `build-windows.yml` (windows-latest)
   - `build-ios.yml` (macos-latest, unsigned)
   Push this repo to GitHub; artifacts appear under each run's **Artifacts**.

2. **Codemagic** — `codemagic.yaml`
   - workflows for Android+Web, Windows, and iOS
   - sign in at https://codemagic.io, connect the repo, and the config is picked up
   - add a `flutter-stable` environment group or adjust the `environment` block

3. **Bitrise** — `bitrise.yml`
   - workflows `android`, `ios`, `windows`
   - add a Bitrise app at https://bitrise.io, connect the repo, and configure
     signing secrets for the `ios` workflow

## Manual local guides

- Windows: `docs/windows.md`
- iOS: `docs/ios.md`
- Linux toolchain internals: `docs/linux-toolchain.md`

## What is still missing / cannot be made available here

- `dotnet` is not installed; it is **not needed** for this Flutter app.
- macOS desktop and iOS require Apple hardware/OS and Xcode.
- Windows desktop requires a Windows host with Visual Studio's
  *Desktop development with C++* workload.
- App Store / TestFlight distribution requires an Apple Developer account and
  signing material; the included iOS CI builds are unsigned.
