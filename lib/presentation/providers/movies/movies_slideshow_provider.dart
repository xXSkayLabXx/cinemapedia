import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entites/movie.dart';
import 'movies_providers.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPalyingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPalyingMovies.isEmpty) return [];
  return nowPalyingMovies.sublist(0, 6);
});
