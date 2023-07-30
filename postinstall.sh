#!/bin/bash

source '/etc/environment'

yes | sdkmanager 'platform-tools' 'platforms;android-33' 'build-tools;34.0.0'
flutter --disable-telemetry
flutter config --android-sdk '/opt/android/sdk'
yes | flutter doctor --android-licenses
