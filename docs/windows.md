# Building Windows locally

Windows desktop cannot be compiled from this Linux host. Use a Windows 10/11 machine (physical or VM) with:

1. **Flutter SDK 3.50.1** — https://docs.flutter.dev/get-started/install/windows
2. **Git for Windows** — https://gitforwindows.org/
3. **Visual Studio 2022** with the **Desktop development with C++** workload
   (this provides the MSVC compiler and Windows SDK Flutter needs).
4. Optional: PowerShell 7+ and VS Code with the Flutter extension.

## Verify

```powershell
flutter doctor -v
```

`Visual Studio` and `Windows` should both show a check mark.

## Build

```powershell
cd path\to\platform_showcase
flutter pub get
flutter analyze
flutter test
flutter build windows --release
```

Release output:

```
build\windows\x64\runner\Release\
```

Zip that folder to distribute. It contains `platform_showcase.exe` plus the
required DLLs and `data/` folder.

## Notes

- Use the same Flutter version as CI (3.50.1) to avoid engine mismatches.
- If you use the GitHub Actions workflow in `.github/workflows/build-windows.yml`,
  none of the above is needed locally; the runner provides it.
