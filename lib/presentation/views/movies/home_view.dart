import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin {


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
    super.build(context);

    final initialLoading = ref.watch(initiaLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final sliedShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPalyingMovies = ref.watch(nowPlayingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upComingMovies = ref.watch(upcomingMoviesProvider);
   // final popularMovies = ref.watch(popularMoviesProvider);


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
                    '${DateFormat.EEEE('es').format(DateTime.now())} ${DateTime.now().day}',
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                },
              ),

              MovieHorizontalListview(
                movies: upComingMovies,
                title: 'Proximamente',
                subTitle: 'En este mes de ${DateFormat.MMMM('es').format(DateTime.now())}',
                loadNextPage: () {
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage();
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

  @override
  bool get wantKeepAlive => true;
}
