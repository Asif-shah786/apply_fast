import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard_template/features/auth/login_page.dart';
import 'package:flutter_admin_dashboard_template/features/auth/splash_page.dart';
import 'package:flutter_admin_dashboard_template/features/users/user_not_found_page.dart';
import 'package:flutter_admin_dashboard_template/providers/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/dashboard/dashbord_page.dart';
import 'features/users/dummy_users.dart';
import 'features/users/user_page.dart';
import 'features/users/users_page.dart';
import 'widgets/widgets.dart';

part 'router.g.dart';

const routerInitialLocation = '/';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    routes: $appRoutes,
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: routerInitialLocation,
    redirect: (context, state) {
      // If our async state is loading, don't perform redirects, yet
      if (authState.isLoading || authState.hasError) return null;

      // Here we guarantee that hasData == true, i.e. we have a readable value

      // This has to do with how the FirebaseAuth SDK handles the "log-in" state
      // Returning `null` means "we are not authorized"
      final isAuth = authState.valueOrNull != null;

      final location = state.uri.toString();
      print('location $location');

      final isSplash = location == '/splash';
      if (isSplash) {
        return isAuth ? '/' : '/login';
      }
      final isLoggingIn = location == '/login';
      if (isLoggingIn) return isAuth ? '/' : null;
      return isAuth ? null : '/splash';
    },
  );
});

@TypedStatefulShellRoute<ShellRouteData>(
  branches: [
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<DashboardRoute>(
          path: routerInitialLocation,
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<UsersPageRoute>(
          path: '/users',
          routes: [
            TypedGoRoute<UserPageRoute>(
              path: ':userId',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<LoginPageRoute>(
          path: '/login',
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<SplashPageRoute>(
          path: '/splash',
        ),
      ],
    ),
  ],
)
class ShellRouteData extends StatefulShellRouteData {
  const ShellRouteData();
  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    // Get the current route name
    final routeName = state.uri.toString();
    bool showNavigation = !(routeName == '/login' ||
        routeName == '/splash' ||
        routeName == '/signup');
    return SelectionArea(
      child: ScaffoldWithNavigation(
        showNavigation: showNavigation,
        navigationShell: navigationShell,
      ),
    );
  }
}

class DashboardRoute extends GoRouteData {
  const DashboardRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DashBoardPage();
  }
}

class SplashPageRoute extends GoRouteData {
  const SplashPageRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashPage();
  }
}

class UsersPageRoute extends GoRouteData {
  const UsersPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UsersPage();
  }
}

class LoginPageRoute extends GoRouteData {
  LoginPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

class UserPageRoute extends GoRouteData {
  const UserPageRoute({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final user = dummyUsers.firstWhereOrNull((e) => e.userId == userId);
    return user == null
        ? UserNotFoundPage(userId: userId)
        : UserPage(user: user);
  }
}
