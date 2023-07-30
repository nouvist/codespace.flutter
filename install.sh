#!/bin/bash

apt-get update
apt-get install -y sudo jq curl git tar xz-utils libarchive-tools \
  openjdk-17-jdk
curl -s https://install.zerotier.com | bash

useradd -m -s /bin/bash -G sudo vscode
echo "vscode  ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vscode

function download_flutter {
  if [[ -f '/tmp/flutter.tar.xz' ]]; then
    echo 'Flutter is already downloaded.'
    return
  fi

  infra_channel='stable'
  infra='https://storage.googleapis.com/flutter_infra_release/releases'
  infra_json="$(curl -s "${infra}/releases_linux.json")"
  infra_hash="$(echo ${infra_json} | \
    jq -r ".current_release.${infra_channel}")"
  infra_release="$(echo ${infra_json} | \
    jq -r ".releases[] | select(.hash == \"${infra_hash}\")")"

  flutter_version="$(echo ${infra_release} | jq -r '.version')"
  dart_version="$(echo ${infra_release} | jq -r '.dart_sdk_version')"
  flutter_archive="${infra}/$(echo ${infra_release} | jq -r '.archive')"

  echo 'Downloading Flutter...'
  echo "Flutter Channel  : ${infra_channel}"
  echo "Flutter Version  : ${flutter_version}"
  echo "Dart Version     : ${dart_version}"
  curl "${flutter_archive}" -o '/tmp/flutter.tar.xz'
}

function extract_flutter {
  echo 'Extracting Flutter...'
  mkdir -p '/opt'
  tar -xvf '/tmp/flutter.tar.xz' -C '/opt'
  chown -R 'vscode:vscode' '/opt/flutter'
}

function download_android_cmd {
  if [[ -f '/tmp/cmdline.zip' ]]; then
    echo 'Android Command Line Tools is already downloaded.'
    return
  fi

  cmdline_archive="$(curl -s 'https://developer.android.com/studio' | \
    grep 'https' | grep 'commandlinetools-linux' | \
    sed -E 's/^\s+href=\"(.+)\"\s*$/\1/')"
  
  echo 'Downloading Android Command Line Tools...'
  curl "${cmdline_archive}" -o '/tmp/cmdline.zip'
}

function extract_android_cmd {
  echo 'Extracting Android Command Line Tools...'
  mkdir -p '/opt/android/sdk/cmdline-tools/latest'
  bsdtar -xvf '/tmp/cmdline.zip' -s '|[^/]*/||' \
    -C '/opt/android/sdk/cmdline-tools/latest'
  chown -R 'vscode:vscode' '/opt/android'
}

function post_install {
  cat >> '/etc/environment' << EOF
ANDROID_HOME="/opt/android/sdk"

PATH="\${PATH}:/opt/flutter/bin"
PATH="\${PATH}:/opt/android/sdk/cmdline-tools/latest/bin"
EOF
}

download_flutter
extract_flutter

download_android_cmd
extract_android_cmd

post_install
