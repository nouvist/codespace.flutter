#!/bin/bash

cat >> '/home/vscode/.environment' << EOF
# global environment
export ANDROID_HOME="/opt/android/sdk"
export PATH="\$PATH:/opt/flutter/bin"
export PATH="\$PATH:/opt/android/sdk/cmdline-tools/latest/bin"
export PATH="\$PATH:/opt/android/sdk/platform-tools"
export PATH="\$PATH:/opt/android/sdk/build-tools/34.0.0"
EOF

echo 'Add environment to ~/.profile...'
echo "source '/home/vscode/.environment'" >> '/home/vscode/.profile'
echo 'Add environment to ~/.zprofile...'
echo "source '/home/vscode/.environment'" >> '/home/vscode/.zprofile'
source '/home/vscode/.environment'

echo 'Installing Android Platform 33...'
yes | sdkmanager 'platform-tools' 'platforms;android-33' 'build-tools;34.0.0'
flutter --disable-telemetry
flutter config --android-sdk '/opt/android/sdk'
yes | flutter doctor --android-licenses
