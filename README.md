# Codespace Flutter Docker Image

[![docker](https://img.shields.io/badge/docker-%230db7ed.svg?logo=docker&logoColor=white)](
https://github.com/nouvist/codespace.flutter/pkgs/container/codespace.flutter)

> Before you can use this Docker image, you need to agree to all the licenses
> for the components inside it, including but not limited to Flutter and
> Android SDK licenses.

A Docker image with Flutter and Android SDK for Codespace. Ths repo is for
myself and only will use the latest stable version. If you want to use
different Flutter version, feel free to fork and rebuild it for yourself.
Don't forget to setup `PUBLISH_TOKEN` with Github token with packages write
access.

But you don't need to build it by yourself. You can also uses my build
[here](https://github.com/nouvist/codespace.flutter/pkgs/container/codespace.flutter).

This repository is configured with both ZeroTier and Tailscale as mesh VPN
solution. Use `service` as `systemctl` substitute.

## What is included?

- Flutter SDK `stable`.
- Android SDK `33`, will updated accordingly to the target SDK version of
  Flutter.
- ZeroTier and Tailscale.

## Usage

Add this to your `devcontainer.json`.

```json
{
  "name": "Flutter Codespace",
  "image": "ghcr.io/nouvist/codespace.flutter:latest",
  "remoteUser": "vscode",
  "features": {
    "ghcr.io/devcontainers/features/common-utils": {
      "installZsh": true,
      "configureZshAsDefaultShell": true,
      "installOhMyZsh": true,
      "username": "vscode",
      "upgradePackages": false
    },
    "ghcr.io/devcontainers/features/github-cli:1": {},
    // optional, if you want to be able ssh
    "ghcr.io/devcontainers/features/sshd:1": {
      "version": "latest"
    },
    // optional, add tailscale as alternative to zerotier
    "ghcr.io/tailscale/codespace/tailscale": {}
  },
  "customizations": {
    "vscode": {
      "extensions": ["Dart-Code.dart-code", "Dart-Code.flutter"]
    }
  },

  // following fields are only required for use with ZeroTier
  // you can remove it if you are not using it
  "runArgs": ["--device=/dev/net/tun"],
  "capAdd": ["NET_ADMIN", "NET_RAW"]
}
```
