import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entites/movie.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fectMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(fetchMoreMovies: fectMoreMovies);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fectMoreMovies = ref.watch(movieRepositoryProvider).getPopular;

  return MoviesNotifier(fetchMoreMovies: fectMoreMovies);
});

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fectMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;

  return MoviesNotifier(fetchMoreMovies: fectMoreMovies);
});

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fectMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;

  return MoviesNotifier(fetchMoreMovies: fectMoreMovies);
});


typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;
  bool isLoading = false;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;

    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];

    await Future.delayed(const Duration(microseconds: 300));
    isLoading = false;
  }
}
