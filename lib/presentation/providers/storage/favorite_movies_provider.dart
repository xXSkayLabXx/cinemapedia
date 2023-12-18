import 'package:cinemapedia/domain/repositories/loca_storage_respository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entites/movie.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRespository: localStorageRepository);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRespository localStorageRespository;

  StorageMoviesNotifier({required this.localStorageRespository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies =
        await localStorageRespository.loadMovies(offset: page * 10, limit: 20);
    page++;

    final tempMovieMap = <int, Movie>{};
    for (final movie in movies) {
      tempMovieMap[movie.id] = movie;
    }
    state = {...state, ...tempMovieMap};

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRespository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
