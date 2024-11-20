import 'package:flutter/material.dart';
import 'package:flutter_starter/screens/home_screen.dart';
import 'package:flutter_starter/screens/login_screen.dart';
import 'package:flutter_starter/screens/profile_screen.dart';
import 'package:flutter_starter/stores/user.store.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

final GoRouter routerConfig = GoRouter(
  refreshListenable: isAuthenticated.toValueListenable(),
  redirect: (_, state) {
    if (state.fullPath == '/profile' && !isAuthenticated.value) {
      return '/login';
    }

    if (state.fullPath == '/login' && isAuthenticated.value) {
      return '/';
    }

    return null;
  },
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
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
  ],
);
