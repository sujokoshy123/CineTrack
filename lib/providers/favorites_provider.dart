import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/movie.dart';

/// StateNotifier holds a list of favorite movies and persists them to Hive
/// (a lightweight on-device NoSQL database) so favorites survive app restarts.
class FavoritesNotifier extends StateNotifier<List<Movie>> {
  FavoritesNotifier() : super([]) {
    _loadFavorites();
  }

  Box get _box => Hive.box('favorites');

  void _loadFavorites() {
    final stored = _box.values.toList();
    state = stored
        .map((e) => Movie.fromJson(Map<String, dynamic>.from(jsonDecode(e))))
        .toList();
  }

  bool isFavorite(int movieId) => state.any((m) => m.id == movieId);

  Future<void> toggleFavorite(Movie movie) async {
    if (isFavorite(movie.id)) {
      await _box.delete(movie.id);
      state = state.where((m) => m.id != movie.id).toList();
    } else {
      await _box.put(movie.id, jsonEncode(movie.toJson()));
      state = [...state, movie];
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Movie>>((ref) {
  return FavoritesNotifier();
});
