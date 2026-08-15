import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import '../providers/movie_providers.dart';
import '../utils/language_filter.dart';
import '../widgets/movie_card.dart';
import '../widgets/loading_view.dart';
import '../widgets/error_view.dart';
import 'detail_screen.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    _TrendingTab(),
    SearchScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.local_movies_rounded, color: AppColors.crimson, size: 26),
            SizedBox(width: 8),
            Text('CINETRACK'),
          ],
        ),
      ),
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.local_fire_department_outlined), selectedIcon: Icon(Icons.local_fire_department), label: 'Trending'),
          NavigationDestination(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.favorite_outline), selectedIcon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }
}

class _TrendingTab extends ConsumerWidget {
  const _TrendingTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingAsync = ref.watch(trendingMoviesProvider);
    final selectedFilter = ref.watch(languageFilterProvider);

    return Column(
      children: [
        // Language filter chips - lets users browse regional cinema.
        SizedBox(
          height: 52,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: LanguageFilter.values.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final filter = LanguageFilter.values[index];
              final isSelected = filter == selectedFilter;
              return ChoiceChip(
                label: Text(filter.label),
                selected: isSelected,
                onSelected: (_) => ref.read(languageFilterProvider.notifier).state = filter,
                showCheckmark: false,
                // Explicit colors override Material 3's default surface tinting,
                // which was washing the chips out to near-white and making
                // the white label text unreadable against it.
                backgroundColor: AppColors.surface,
                selectedColor: AppColors.crimson,
                surfaceTintColor: Colors.transparent,
                side: BorderSide(color: Colors.white.withOpacity(0.15)),
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  color: isSelected ? Colors.white : Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ),
        Expanded(
          child: trendingAsync.when(
            loading: () => const LoadingView(),
            error: (err, _) => ErrorView(
              message: err.toString(),
              onRetry: () => ref.refresh(trendingMoviesProvider),
            ),
            data: (movies) {
              if (movies.isEmpty) {
                return const Center(child: Text('No movies found for this filter'));
              }
              return RefreshIndicator(
                onRefresh: () async => ref.refresh(trendingMoviesProvider),
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return MovieCard(
                      movie: movie,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DetailScreen(movie: movie)),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
