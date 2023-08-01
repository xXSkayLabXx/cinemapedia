import '../entites/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNouPlaying({int page = 1});
}
