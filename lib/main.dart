import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final baseTextTheme = GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme);

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
        textTheme: baseTextTheme,
        // Bebas Neue gives headings that cinema-poster / marquee feel.
        primaryTextTheme: baseTextTheme,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: GoogleFonts.bebasNeue(
            fontSize: 32,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.crimson.withOpacity(0.25),
          labelTextStyle: WidgetStateProperty.all(
            GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surface,
          selectedColor: AppColors.crimson,
          labelStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
