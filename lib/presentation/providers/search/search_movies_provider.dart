import 'package:cinemapedia/domain/entites/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../movies/movies_repository_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {

    final movieRepository = ref.read(movieRepositoryProvider);


  return SearchedMoviesNotifier(
    ref: ref, 
    searchMovies: movieRepository.searchMovies
    );
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final Ref ref;

  final SearchMoviesCallback searchMovies;

  SearchedMoviesNotifier({required this.ref, required this.searchMovies})
      : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;
    return movies;
  }
}
