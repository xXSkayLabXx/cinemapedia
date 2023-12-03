import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [
  GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        int pagesIndex = int.parse(state.pathParameters['page'] ?? '0');
        if (pagesIndex > 2 || pagesIndex < 0) {
          pagesIndex = 0;
        }
        return HomeScreen(
          pageIndex: pagesIndex,
        );
      },
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final moveId = state.pathParameters['id'] ?? 'no-id';

            return MovieScreen(movieId: moveId);
          },
        ),
      ]),
  GoRoute(path: '/', redirect: (_, __) => '/home/0'),
]);
