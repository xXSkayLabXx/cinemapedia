import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNaviagation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initiaLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final nowPalyingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upComingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    final sliedShowMovies = ref.watch(moviesSlideshowProvider);
 
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              // const CustomAppbar(),

              MoviesSlideshow(movies: sliedShowMovies),
              MovieHorizontalListview(
                movies: nowPalyingMovies,
                title: 'En cines',
                subTitle:
                    '${DateFormat.EEEE().format(DateTime.now())} ${DateTime.now().day}',
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                },
              ),

              MovieHorizontalListview(
                movies: upComingMovies,
                title: 'Proximamente',
                loadNextPage: () {
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                },
              ),
              MovieHorizontalListview(
                movies: popularMovies,
                title: 'En Populares',
                subTitle: 'En ${DateFormat.MMMM().format(DateTime.now())}',
                loadNextPage: () {
                  ref.read(popularMoviesProvider.notifier).loadNextPage();
                },
              ),
              MovieHorizontalListview(
                movies: topRatedMovies,
                title: 'Mejor Calificada',
                subTitle: 'De todos los tiempos',
                loadNextPage: () {
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                },
              ),

              const SizedBox(
                height: 10,
              )
            ],
          );
        }, childCount: 1))
      ],
    );
  }
}
