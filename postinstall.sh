#!/bin/bash
flutter --disable-telemetry
flutter config --android-sdk '/opt/android/sdk'

sdkmanager 'platform-tools' 'platforms;android-33' 'build-tools;34.0.0'
