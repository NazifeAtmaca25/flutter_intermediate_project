# Movie Search App

A Flutter application that fetches movie data from the TMDB (The Movie Database) API, lists popular titles, and lets users search for specific movies. Each card shows the poster, release year, and rating, and the detail screen displays the overview with a backdrop image.

## Tech Stack
- Flutter & Material design widgets
- REST requests through the `http` package
- `flutter_dotenv` to keep the API key outside the source
- Grid-based listing plus a detail screen built with `Stack` and `SingleChildScrollView`

## Getting Started
1. Install dependencies defined in `pubspec.yaml`:
   ```bash
   flutter pub get
   ```
2. Create a `.env` file in the project root and add your TMDB key:
   ```
   TMDB_API_KEY=put_your_key_here
   ```
3. Run the application on a simulator or device:
   ```bash
   flutter run
   ```

## Features
- Loads popular movies automatically on launch.
- Sends search requests to TMDB when the user types a title.
- Falls back to the local `assets/images/no_image.jpg` when a poster is missing.
- Detail screen shows backdrop image, poster, IMDb-like rating, and the plot summary.
