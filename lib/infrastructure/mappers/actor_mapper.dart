import 'package:cinemapedia/domain/entites/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) =>
      Actor(
        id: cast.id, 
        name: cast.name, 
        profilePath: cast.profilePath != null
        ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
        : 'https://i.stack.imgur.com/l60Hf.png', 
        character: cast.character
        );
}
