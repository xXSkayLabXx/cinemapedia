import '../entites/movie.dart';

abstract class MovieDatasource {
  Future<List<Movie>> getNouPlaying({int page = 1});
}
