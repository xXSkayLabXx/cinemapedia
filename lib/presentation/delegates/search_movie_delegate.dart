import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/huma_formats.dart';
import 'package:flutter/material.dart';

import '../../domain/entites/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  List<Movie> initialMovies;

  final SearchMoviesCallback searchMovies;

  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchMovieDelegate(
      {required this.initialMovies, required this.searchMovies});

  void clearStreams() {
    debounceMovies.close();
  }
// realiza el cambio en pantalla del estado mostrando la animacion de cargar y escritura
  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      initialMovies = movies;
      debounceMovies.add(movies);
      isLoadingStream.add(false);
    });
  }

  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
          initialData: false,
          stream: isLoadingStream.stream,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) {
              return SpinPerfect(
                  infinite: true,
                  spins: 10,
                  duration: const Duration(seconds: 20),
                  child: IconButton(
                      onPressed: () => query = '',
                      icon: const Icon(Icons.refresh_rounded)));
            }
            return FadeIn(
                animate: query.isNotEmpty,
                duration: const Duration(milliseconds: 200),
                child: IconButton(
                    onPressed: () => query = '',
                    icon: const Icon(Icons.clear)));
          }),

      /* */
    ];
  }

  Widget buildRessultsAndSuggestions() {
    _onQueryChanged(query);

    return StreamBuilder(
      //future: searchMovies(query),
      stream: debounceMovies.stream,
      initialData: initialMovies,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
              movie: movies[index],
              onMovieSeleted: (context, movie) {
                clearStreams();
                close(context, movie);
              }),
        );
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildRessultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildRessultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSeleted;

  const _MovieItem({required this.movie, required this.onMovieSeleted});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSeleted(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            //image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  height: 130,
                  fit: BoxFit.cover,
                  image: NetworkImage(movie.posterPath),
                  placeholder: const AssetImage('assets/loader/bottle-loader.gif'),
                  ),
                ),
              ),
          
            const SizedBox(
              width: 10,
            ),
            //description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyle.titleMedium,
                  ),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.amber.shade800,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyle.bodyMedium!
                            .copyWith(color: Colors.amber.shade900),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
