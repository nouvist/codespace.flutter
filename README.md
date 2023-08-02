# codespace.flutter

A Docker image with Flutter and Android SDK for Codespace. I made it mainly for
myself.

## What is included?

- Flutter SDK `stable`
- Android SDK `33` (will updated accordingly to the target SDK version of
  Flutter)
- ZeroTier

## Usage

> Before you can use this Docker image, you need to agree to all the licenses
> for the components inside it, including but not limited to Flutter and
> Android SDK licenses.

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
    }
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

### ZeroTier Usage

See [ZeroTier documentation](https://docs.zerotier.com/getting-started/getting-started#setup-the-zerotier-app) for more.

SystemD may not be enabled in some container. If that the case, use `service`
tool instead of `systemctl`.
