import 'package:cinemapedia/domain/entites/entities.dart';

import '../entites/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});

  Future<List<Movie>> searchMovies(String query);
  Future<Movie> getMovieById(String id);

  Future<List<Movie>> getSimiliarMovies(int movieId);
  Future<List<Video>> getYoutubeVideosById(int movieId);
}
