#!/bin/bash

cat >> '~/.environment' << EOF
ANDROID_HOME="/opt/android/sdk"
PATH="\$PATH:/opt/flutter/bin"
PATH="\$PATH:/opt/android/sdk/cmdline-tools/latest/bin"
PATH="\$PATH:/opt/android/sdk/platform-tools"
PATH="\$PATH:/opt/android/sdk/build-tools/34.0.0"
EOF

echo 'source '~/.environment'' >> '~/.bashrc'
echo 'source '~/.environment'' >> '~/.zshrc'
source '~/.environment'

yes | sdkmanager 'platform-tools' 'platforms;android-33' 'build-tools;34.0.0'
flutter --disable-telemetry
flutter config --android-sdk '/opt/android/sdk'
yes | flutter doctor --android-licenses
