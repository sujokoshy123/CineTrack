import 'package:flutter_test/flutter_test.dart';
import 'package:cinetrack/models/movie.dart';

void main() {
  group('Movie.fromJson', () {
    test('parses a valid TMDB movie JSON correctly', () {
      final json = {
        'id': 27205,
        'title': 'Inception',
        'overview': 'A thief who steals corporate secrets...',
        'poster_path': '/edv5CZvWj09upOsy2Y6IwDhK8bt.jpg',
        'vote_average': 8.4,
        'release_date': '2010-07-15',
      };

      final movie = Movie.fromJson(json);

      expect(movie.id, 27205);
      expect(movie.title, 'Inception');
      expect(movie.voteAverage, 8.4);
      expect(movie.posterUrl, contains('edv5CZvWj09upOsy2Y6IwDhK8bt.jpg'));
    });

    test('falls back to defaults when fields are missing', () {
      final json = {'id': 1};
      final movie = Movie.fromJson(json);

      expect(movie.title, 'Untitled');
      expect(movie.overview, '');
      expect(movie.posterPath, null);
      expect(movie.voteAverage, 0.0);
    });
  });
}
