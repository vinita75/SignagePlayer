# Flutter Signage Player

A digital signage player that pre-downloads all media, then loops through
images and videos, displaying each for exactly 10 seconds.

## How to Run

This repo ships only the `lib/`, `assets/`, and `pubspec.yaml` files (the
Dart source). Flutter's platform folders (`android/`, `ios/`, etc.) are
generated locally rather than committed, since they're large,
machine-specific boilerplate. To run it:

1. **Scaffold a new Flutter project** (creates the platform folders):
   ```
   flutter create flutter_signage_player
   cd flutter_signage_player
   ```

2. **Copy this repo's files in**, overwriting the generated ones:
   - Replace the generated `pubspec.yaml` with the one in this repo.
   - Replace the generated `lib/` folder with this repo's `lib/`.
   - Copy this repo's `assets/` folder into the project root.

3. **Add the internet permission** (required to download media) in
   `flutter pub getandroid/app/src/main/AndroidManifest.xml`, inside the `<manifest>` tag:
   ```xml
   <uses-permission android:name="android.permission.INTERNET"/>
   ```

4. **Install dependencies:**
   ```
   flutter pub get
   ```

5. **Run:**
   ```
   flutter run
   ```

6. **Build a release APK:**
   ```
   flutter build apk --release
   ```
   The APK will be at `build/app/outputs/flutter-apk/app-release.apk`.

## Assumptions

- If a file fails to download (network error, timeout, non-200
  response), it's silently excluded from the playback loop rather than
  blocking the splash screen forever or crashing the app. This keeps the
  demo resilient to a single flaky sample URL.
- Downloaded files are stored in the app's documents directory and are
  re-downloaded on every app launch (no persistent on-disk cache check
  across sessions), since the assignment scope is "download before
  playback," not "cache across app restarts."
- Videos are assumed to already be in a device-playable format (mp4),
  as given in the content list.
- Minimum practical screen size is assumed to be a phone/tablet in
  landscape or portrait; no orientation lock is applied since none was
  specified.
