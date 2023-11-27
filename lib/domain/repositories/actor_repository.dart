import '../entites/actor.dart';

abstract class ActorRepository {
  Future<List<Actor>> getActorByMovie(String moviId);
}
