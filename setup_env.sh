#!/usr/bin/env bash
# Source this file before using Flutter on this Linux host.
# It adds the root-free toolchain in ~/.local and the pre-existing Android SDK.

_PREFIX="$HOME/.local/sysroot"
_SDK="$HOME/Android/Sdk"

export ANDROID_HOME="$_SDK"
export ANDROID_SDK_ROOT="$_SDK"
export PATH="$HOME/.local/bin:$_PREFIX/usr/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"
export PKG_CONFIG_PATH="$_PREFIX/usr/lib/x86_64-linux-gnu/pkgconfig:$_PREFIX/usr/share/pkgconfig:${PKG_CONFIG_PATH:-}"
export PKG_CONFIG_LIBDIR="$_PREFIX/usr/lib/x86_64-linux-gnu/pkgconfig:$_PREFIX/usr/share/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig"
export CPATH="$_PREFIX/usr/include:$_PREFIX/usr/include/x86_64-linux-gnu:${CPATH:-}"
export LIBRARY_PATH="$_PREFIX/usr/lib/x86_64-linux-gnu:${LIBRARY_PATH:-}"
export LD_LIBRARY_PATH="$_PREFIX/usr/lib/x86_64-linux-gnu:$_PREFIX/usr/lib:$_PREFIX/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH:-}"

unset _PREFIX _SDK
