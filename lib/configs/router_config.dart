import 'package:flutter/material.dart';
import 'package:flutter_starter/screens/home_screen.dart';
import 'package:flutter_starter/screens/login_screen.dart';
import 'package:flutter_starter/screens/profile_screen.dart';
import 'package:flutter_starter/stores/user.store.dart';
import 'package:go_router/go_router.dart';

final GoRouter routerConfig = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen(title: 'Flutter Demo Home Page');
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileScreen();
      },
      redirect: (context, state) {
        if (!isAuthenticated.value) return '/login';

        return null;
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
      redirect: (context, state) {
        if (isAuthenticated.value) return '/';

        return null;
      },
    ),
  ],
);
