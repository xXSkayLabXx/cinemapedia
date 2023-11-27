import 'package:cinemapedia/domain/datasources/actor_datasource.dart';
import 'package:cinemapedia/domain/entites/actor.dart';
import 'package:cinemapedia/domain/repositories/actor_repository.dart';

class ActorRepositoryImpl extends ActorRepository {
  final ActorDatasource datasource;

  ActorRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorByMovie(String moviId) {
    return datasource.getActorByMovie(moviId);
  }
}
