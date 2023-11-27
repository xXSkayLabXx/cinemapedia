import 'package:cinemapedia/domain/entites/actor.dart';

abstract class ActorDatasource {
  Future<List<Actor>> getActorByMovie(String movieId);
}
