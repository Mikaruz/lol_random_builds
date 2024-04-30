import 'package:go_router/go_router.dart';
import 'package:lol_random_builds/presentation/screens/build_random_screen.dart';
import 'package:lol_random_builds/presentation/screens/welcome_screen.dart';

final appRouter = GoRouter(initialLocation: '/welcome', routes: [
  GoRoute(
    path: '/welcome',
    builder: (context, state) => const WelcomeScreen(),
  ),
  GoRoute(
    path: '/build-random',
    builder: (context, state) => const BuilRandomScreen(),
  ),
]);
