# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Alt_Recipe is a Flutter mobile application for iOS and Android. This is currently a standard Flutter starter template with minimal customization.

## Development Commands

### Running the Application
```bash
# Run on connected device/emulator
flutter run

# Run with hot reload enabled (press 'r' to reload, 'R' to restart)
flutter run

# Run on specific device
flutter devices              # List available devices
flutter run -d <device_id>   # Run on specific device
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage
```

### Code Quality
```bash
# Run static analysis
flutter analyze

# Format all Dart files
dart format .

# Format specific file
dart format lib/main.dart
```

### Building
```bash
# Build for Android
flutter build apk              # Release APK
flutter build appbundle        # Android App Bundle (for Play Store)

# Build for iOS
flutter build ios              # Release build
flutter build ipa              # For App Store

# Build for development
flutter build apk --debug
```

### Dependency Management
```bash
# Get dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade

# Check for outdated packages
flutter pub outdated
```

## Code Architecture

### Current Structure
```
lib/
└── main.dart          # Entry point with MyApp root widget

test/
└── widget_test.dart   # Basic widget tests
```

### Key Components

**main.dart**: Contains the application entry point and boilerplate demo code:
- `MyApp`: Root StatelessWidget that configures MaterialApp
- `MyHomePage`: StatefulWidget demonstrating a simple counter
- Uses Material Design with ColorScheme.fromSeed

### Configuration Files

- **pubspec.yaml**: Project configuration, dependencies (currently minimal - only cupertino_icons)
- **analysis_options.yaml**: Uses flutter_lints package for static analysis
- SDK version: ^3.8.1

### Platform-Specific Code

- **android/**: Native Android configuration using Gradle (KTS format)
- **ios/**: Native iOS configuration using Xcode project structure

## Supabase Integration & Google OAuth Setup

### Project Identifiers
- **Package Name (Android)**: `blue.lemon.alt_recipe`
- **Bundle ID (iOS)**: Will need to be configured in Xcode

### Android Keystore Information

#### Debug Keystore (Development)
- **Location**: `~/.android/debug.keystore`
- **Password**: `android`
- **Alias**: `androiddebugkey`

**SHA-1 Fingerprint**: `25:77:14:2C:A1:74:63:07:37:A8:85:51:93:6C:4F:24:FE:16:56:28`
**SHA-256 Fingerprint**: `B2:7B:83:36:33:B5:A5:3C:A0:FE:AE:EF:3E:44:68:8D:F1:F9:7B:4E:AA:A0:4D:28:43:2B:7A:10:BA:91:01:A4`

To get keystore fingerprints:
```bash
# Debug keystore
keytool -keystore ~/.android/debug.keystore -list -v -storepass android

# Production keystore (when created)
keytool -keystore /path/to/upload-keystore.jks -list -v
```

#### Production Keystore (for Release)
- **Status**: Not yet created
- **Current Config**: Release builds use debug keystore (android/app/build.gradle.kts:37)
- **TODO**: Create production keystore before Play Store release

### GCP OAuth 2.0 Setup Requirements

#### 1. GCP Console Configuration
1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Create or select project
3. Enable Google+ API / Google Sign-In API
4. Go to **APIs & Services** > **Credentials**
5. Create **OAuth 2.0 Client ID**

#### 2. OAuth Client IDs Needed

**Android OAuth Client**:
- Application type: `Android`
- Package name: `blue.lemon.alt_recipe`
- SHA-1 certificate fingerprint: `25:77:14:2C:A1:74:63:07:37:A8:85:51:93:6C:4F:24:FE:16:56:28`
- SHA-256 certificate fingerprint: `B2:7B:83:36:33:B5:A5:3C:A0:FE:AE:EF:3E:44:68:8D:F1:F9:7B:4E:AA:A0:4D:28:43:2B:7A:10:BA:91:01:A4`

**iOS OAuth Client** (when iOS is configured):
- Application type: `iOS`
- Bundle ID: (to be determined from Xcode project)

**Web OAuth Client** (for Supabase):
- Application type: `Web application`
- Authorized redirect URIs: `https://<your-project-ref>.supabase.co/auth/v1/callback`

#### 3. Supabase Dashboard Configuration
1. Go to Supabase project dashboard
2. Navigate to **Authentication** > **Providers**
3. Enable **Google** provider
4. Add Google OAuth credentials:
   - Client ID: From GCP Web OAuth Client
   - Client Secret: From GCP Web OAuth Client
5. Add authorized redirect URL to GCP console

#### 4. Flutter App Configuration

Required packages (add to pubspec.yaml):
```yaml
dependencies:
  supabase_flutter: ^latest_version
  google_sign_in: ^latest_version
```

Android configuration (android/app/build.gradle.kts):
```kotlin
defaultConfig {
    minSdk = 21  // Minimum for Google Sign-In
}
```

### Important Notes
- Debug keystore fingerprints are only for development/testing
- Before production release, create a production keystore and add its fingerprints to GCP
- Never commit keystore files or credentials to version control
- Store production keystore securely (backup is critical - if lost, cannot update app)

## Development Notes

- This is a fresh Flutter project with the default counter demo app
- No custom state management, routing, or architecture patterns implemented yet
- No external packages beyond cupertino_icons
- Linting enabled via flutter_lints package
- Supabase integration planned with Google OAuth authentication
