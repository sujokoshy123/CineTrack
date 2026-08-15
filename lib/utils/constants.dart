class ApiConstants {
  // This key is injected at BUILD TIME by GitHub Actions using --dart-define,
  // so it never gets committed to the repo. See .github/workflows/*.yml
  // For local runs without Actions, you can temporarily hardcode it here instead.
  static const String apiKey = String.fromEnvironment(
    'TMDB_API_KEY',
    defaultValue: 'YOUR_TMDB_API_KEY',
  );
  static const String baseUrl = 'https://api.themoviedb.org/3';
}
