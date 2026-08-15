# 🎬 CineTrack

A cross-platform movie discovery app built with **Flutter**, **Riverpod**, and the **TMDB REST API**. Browse trending movies, search by title, and save favorites — all with offline persistence.

> Personal project built to practice Flutter, state management, and REST API integration.

🔗 **Live demo:** `https://YOUR_USERNAME.github.io/cinetrack` (builds automatically via GitHub Actions on every push)

<!-- Add a screenshot or screen-recording GIF here once you run the app -->
<!-- ![CineTrack Screenshot](screenshots/home.png) -->

## ✨ Features

- 🔥 Browse trending movies (updated weekly via TMDB)
- 🌏 Filter by language — Malayalam, Tamil, Telugu, Hindi, or English
- 🔍 Search movies by title, with debounced input
- ❤️ Save favorites locally — works even offline
- 🎨 Movie detail screen with hero animation, rating, and overview
- ⚠️ Proper loading, empty, and error states with retry
- 🌙 Cinematic dark theme with a crimson/gold accent palette

## 🛠 Tech Stack

| Layer | Choice |
|---|---|
| Language | Dart |
| Framework | Flutter |
| State Management | Riverpod (`flutter_riverpod`) |
| Networking | `http` |
| Local Storage | `Hive` |
| Image Caching | `cached_network_image` |
| API | [TMDB (The Movie Database)](https://www.themoviedb.org/documentation/api) |

## 📂 Project Structure

```
lib/
├── main.dart                  # App entry point
├── models/
│   └── movie.dart              # Movie data model + JSON parsing
├── services/
│   └── tmdb_service.dart       # All REST API calls live here
├── providers/
│   ├── movie_providers.dart    # Riverpod providers for trending/search
│   └── favorites_provider.dart # Favorites state + Hive persistence
├── screens/
│   ├── home_screen.dart        # Bottom nav + trending tab
│   ├── search_screen.dart      # Search UI
│   ├── favorites_screen.dart   # Saved favorites
│   └── detail_screen.dart      # Movie detail page
└── widgets/
    ├── movie_card.dart         # Reusable poster card
    ├── loading_view.dart       # Loading spinner
    └── error_view.dart         # Error + retry UI
```

## 🚀 Getting Started (no local Flutter install required)

This project builds entirely on GitHub's servers using GitHub Actions. You only need Git and a browser.

### 1. Get a free TMDB API key
Sign up at https://www.themoviedb.org/settings/api and request a Developer API key (instant approval).

### 2. Push this repo to GitHub
```bash
git init
git add .
git commit -m "Initial commit: CineTrack v1"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/cinetrack.git
git push -u origin main
```

### 3. Add your API key as a GitHub Secret
In your repo: **Settings → Secrets and variables → Actions → New repository secret**
- Name: `TMDB_API_KEY`
- Value: your actual key

This keeps the key out of your public source code.

### 4. Enable GitHub Pages
**Settings → Pages → Source → set to "Deploy from a branch" → branch: `gh-pages`**
(This branch gets created automatically the first time the `Deploy Web Demo` workflow runs.)

### 5. Push and watch it build
Any push to `main` automatically triggers the **Deploy Web Demo** workflow (see the "Actions" tab in your repo to watch it run). Once it finishes, your app is live at:
```
https://YOUR_USERNAME.github.io/cinetrack
```

### 6. Get an installable Android APK (optional)
```bash
git tag v1.0.0
git push --tags
```
This triggers the **Build APK Release** workflow, which attaches a ready-to-install `app-release.apk` to a new GitHub Release. Download it, transfer to an Android phone, and install (you'll need to allow "install from unknown sources").

## 🧪 Running Tests
Tests run automatically in CI on every push (see `.github/workflows/flutter_ci.yml`). To run them yourself, you'd need Flutter installed locally: `flutter test`.

## 📌 Possible Improvements
- [ ] Pagination / infinite scroll on trending list
- [ ] Genre filters
- [ ] Trailer playback (YouTube API)
- [ ] Bloc version as an alternate branch to compare state management approaches

## 📄 License
This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.
