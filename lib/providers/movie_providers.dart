import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';
import '../services/tmdb_service.dart';
import '../utils/language_filter.dart';

final tmdbServiceProvider = Provider<TMDBService>((ref) => TMDBService());

// Holds which language chip is currently selected on the Trending tab.
final languageFilterProvider = StateProvider<LanguageFilter>((ref) => LanguageFilter.all);

// Watches languageFilterProvider - whenever the user taps a different chip,
// this re-runs automatically and fetches the right set of movies.
final trendingMoviesProvider = FutureProvider.autoDispose<List<Movie>>((ref) async {
  final service = ref.watch(tmdbServiceProvider);
  final filter = ref.watch(languageFilterProvider);

  if (filter == LanguageFilter.all) {
    return service.getTrendingMovies();
  }
  return service.discoverByLanguage(filter.code);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider.autoDispose<List<Movie>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  final service = ref.watch(tmdbServiceProvider);
  return service.searchMovies(query);
});
