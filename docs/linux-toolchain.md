# Linux desktop toolchain on this host

The Flutter snap is installed, but its first run downloads the full SDK and
it does not include native Linux desktop build tools. This repo includes a
**root-free local toolchain** under `~/.local` so builds work without `sudo`.

## What was set up

- `~/.local/sysroot` — extracted `.deb` contents for GTK 3 development files
  and friends, from the exact package set reported by:

  ```bash
  apt-get -s install --no-install-recommends \
    libgtk-3-dev clang cmake ninja-build g++ pkg-config liblzma-dev mesa-utils
  ```

- `~/.local/bin` — small wrappers:
  - `clang`, `clang++` → `/usr/lib/llvm-18/bin/clang(++)` (LLVM 18 is already
    installed system-wide; only the `clang` alternatives package was missing)
  - `cmake`, `ninja` → the extracted binaries
- `.pc` files in the sysroot were rewritten so `prefix`, `original_prefix`,
  and absolute `/usr/include` / `/usr/lib` paths point into `~/.local/sysroot`.
- `setup_env.sh` in the project root exports:
  - `ANDROID_HOME` / `ANDROID_SDK_ROOT` → `~/Android/Sdk`
  - `PATH` prepended with the local bin, Android cmdline-tools and platform-tools
  - `PKG_CONFIG_PATH`, `PKG_CONFIG_LIBDIR`, `CPATH`, `LIBRARY_PATH`,
    `LD_LIBRARY_PATH` pointing at the local sysroot (plus system pkg-config
    directories for transitively installed packages such as `zlib` and `x11`)

## Use it

```bash
cd ~/Documents/Default\ Project/cross_platform_demo
source ./setup_env.sh
flutter doctor        # Linux toolchain + Android toolchain should be green
flutter build linux --release
flutter build web --release
flutter build apk --release
```

`~/.bashrc` has also been updated to source this file automatically in new shells.

## If you prefer a normal system install

You need root once:

```bash
sudo apt update
sudo apt install -y clang cmake ninja-build g++ pkg-config \
  libgtk-3-dev liblzma-dev mesa-utils
```

Then no `setup_env.sh` is required except for the Android SDK variables:

```bash
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"
```

## Known harmless warning

`flutter doctor` reports two `adb` binaries:

```
- ~/Android/Sdk/platform-tools/adb
- /usr/lib/android-sdk/platform-tools/adb
```

`setup_env.sh` puts the SDK one first on `PATH`, so builds and device
detection use the correct one. Removing the duplicate requires root and is
optional.
