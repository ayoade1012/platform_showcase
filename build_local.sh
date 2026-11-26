#!/usr/bin/env bash
# Build every target that can be built on this Linux host.
set -euo pipefail
cd "$(dirname "$0")"
source ./setup_env.sh

flutter pub get
flutter analyze
flutter test

flutter build web --release
flutter build linux --release
flutter build apk --release

printf '\nLocal builds complete:\n'
printf '  Web:    %s\n' "$(pwd)/build/web"
printf '  Linux:  %s\n' "$(pwd)/build/linux/x64/release/bundle"
printf '  Android: %s\n' "$(pwd)/build/app/outputs/flutter-apk/app-release.apk"
