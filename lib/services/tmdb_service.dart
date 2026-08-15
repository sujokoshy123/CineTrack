import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../utils/constants.dart';

/// Handles all communication with the TMDB REST API.
/// Keeping this in its own class means the UI never talks to http directly.
class TMDBService {
  Future<List<Movie>> getTrendingMovies({int page = 1}) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}/trending/movie/week?api_key=${ApiConstants.apiKey}&page=$page');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;
      return results.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load trending movies (${response.statusCode})');
    }
  }

  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    if (query.trim().isEmpty) return [];
    final url = Uri.parse(
        '${ApiConstants.baseUrl}/search/movie?api_key=${ApiConstants.apiKey}&query=${Uri.encodeComponent(query)}&page=$page');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;
      return results.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search movies (${response.statusCode})');
    }
  }

  /// Uses TMDB's /discover endpoint to fetch popular movies in a specific
  /// original language (e.g. 'ml' for Malayalam, 'ta' for Tamil).
  /// The regular /trending endpoint doesn't support language filtering,
  /// so regional movies need this separate call.
  Future<List<Movie>> discoverByLanguage(String languageCode, {int page = 1}) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}/discover/movie?api_key=${ApiConstants.apiKey}&with_original_language=$languageCode&sort_by=popularity.desc&page=$page');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;
      return results.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies (${response.statusCode})');
    }
  }
}
