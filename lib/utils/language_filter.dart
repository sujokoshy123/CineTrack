/// Represents a language filter chip shown on the Trending tab.
/// TMDB identifies movies by their original language using ISO 639-1 codes.
enum LanguageFilter { all, malayalam, tamil, telugu, hindi, english }

extension LanguageFilterX on LanguageFilter {
  /// The code TMDB expects in `with_original_language`. Empty means "no filter".
  String get code {
    switch (this) {
      case LanguageFilter.malayalam:
        return 'ml';
      case LanguageFilter.tamil:
        return 'ta';
      case LanguageFilter.telugu:
        return 'te';
      case LanguageFilter.hindi:
        return 'hi';
      case LanguageFilter.english:
        return 'en';
      case LanguageFilter.all:
        return '';
    }
  }

  String get label {
    switch (this) {
      case LanguageFilter.all:
        return 'All';
      case LanguageFilter.malayalam:
        return 'Malayalam';
      case LanguageFilter.tamil:
        return 'Tamil';
      case LanguageFilter.telugu:
        return 'Telugu';
      case LanguageFilter.hindi:
        return 'Hindi';
      case LanguageFilter.english:
        return 'English';
    }
  }
}
