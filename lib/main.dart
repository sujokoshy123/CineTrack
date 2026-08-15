import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('favorites');

  runApp(const ProviderScope(child: CineTrackApp()));
}

// Cinematic color palette: deep charcoal background, crimson accent for
// favorites/highlights, warm gold for ratings - evokes a movie-theatre feel.
class AppColors {
  static const background = Color(0xFF0E0E10);
  static const surface = Color(0xFF1B1B1F);
  static const crimson = Color(0xFFE63950);
  static const gold = Color(0xFFF5C542);
}

class CineTrackApp extends StatelessWidget {
  const CineTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Fonts are bundled locally (see pubspec.yaml / assets/fonts) instead of
    // fetched over the network at runtime - this avoids the font-swap flash
    // (blurry text) that happens with remotely-loaded web fonts.
    const baseTextTheme = TextTheme(
      bodyLarge: TextStyle(fontFamily: 'Poppins'),
      bodyMedium: TextStyle(fontFamily: 'Poppins'),
      bodySmall: TextStyle(fontFamily: 'Poppins'),
      titleLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      titleSmall: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
      labelLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
    );

    return MaterialApp(
      title: 'CineTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.crimson,
          brightness: Brightness.dark,
          primary: AppColors.crimson,
          secondary: AppColors.gold,
          surface: AppColors.surface,
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
        textTheme: baseTextTheme,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: 32,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.crimson.withOpacity(0.25),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontFamily: 'Poppins', fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surface,
          selectedColor: AppColors.crimson,
          labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
