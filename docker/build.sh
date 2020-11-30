---
name: CI/CD
on:
  push:
    branches:
      - master
  pull_request:
jobs:
  ubuntu:
    name: Build Linux on Ubuntu
    runs-on: ubuntu-latest
    steps:
    - name: Update Container
      run: sudo apt-get update -qq
    - name: Instal SFML
      run: sudo apt-get install libsfml-dev
    - name: Checkout EmptyEpsilon
      uses: actions/checkout@v2
    - name: Build Linux Deb
      run: docker/build.sh linux
    - name: Upload EmptyEpsilon.deb artifact
      uses: actions/upload-artifact@v2
      with:
        name: Linux Debian
        path: /home/runner/work/EmptyEpsilon/EmptyEpsilon/build/EmptyEpsilon.deb
        if-no-files-found: error
    - name: Upload script_reference.html artifact
      uses: actions/upload-artifact@v2
      with:
        name: Script Reference
        path: /home/runner/work/EmptyEpsilon/EmptyEpsilon/build/script_reference.html
        if-no-files-found: error
  win32:
    name: Build Win32 on Ubuntu
    runs-on: ubuntu-latest
    steps:
    - name: Update Container
      run: sudo apt-get update -qq
    - name: Install tools and SFML
      run: sudo apt-get install build-essential cmake python3-minimal mingw-w64 ninja-build p7zip-full libsfml-dev
    - name: Checkout EmptyEpsilon
      uses: actions/checkout@v2
    - name: Build Windows 32-bit
      run: docker/build.sh win32
    - name: Upload Win32 Artifact
      uses: actions/upload-artifact@v2
      with:
        name: Windows
        path: /home/runner/work/EmptyEpsilon/EmptyEpsilon/_build_win32/upload/
        if-no-files-found: error
  macos:
    name: Build Mac on MacOS
    runs-on: macos-latest
    steps:
    - name: Update Container
      run: sudo softwareupdate -ia
    - name: Install SFML
      run: brew install cmake sfml
    - name: Checkout EmptyEpsilon
      uses: actions/checkout@v2
    - name: Build MacOS
      run: docker/build.sh macos
    - name: Upload MacOS Artifact
      uses: actions/upload-artifact@v2
      with:
        name: MacOS
        path: /Users/runner/work/EmptyEpsilon/EmptyEpsilon/_build/EmptyEpsilon.dmg
        if-no-files-found: error
  android:
    name: Build Android on Ubuntu
    runs-on: ubuntu-latest
    steps:
    - name: Update Container
      run: sudo apt-get update -qq
    - name: Install Tools and SFML
      run: sudo apt-get install build-essential cmake python3-minimal mingw-w64 ninja-build p7zip-full libsfml-dev
    - name: Checkout EmptyEpsilon
      uses: actions/checkout@v2
    - name: Build Android
      run: docker/build.sh android
    - name: Upload Android Artifact
      uses: actions/upload-artifact@v2
      with:
        name: Android
        path: /home/runner/work/EmptyEpsilon/EmptyEpsilon/_build_android/EmptyEpsilon.apk
        if-no-files-found: error
