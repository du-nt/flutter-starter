import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_starter/hooks/use_query.dart';
import 'package:flutter_starter/models/profile_model.dart';
import 'package:flutter_starter/screens/home_screen.dart';
import 'package:flutter_starter/screens/login_screen.dart';
import 'package:flutter_starter/screens/profile_screen.dart';
import 'package:flutter_starter/stores/user.store.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

void main() {
  runApp(QueryClientProvider(
      queryClient: QueryClient(
        defaultQueryOptions: DefaultQueryOptions(
          cacheDuration: const Duration(minutes: 20),
          refetchInterval: null,
          refetchOnMount: RefetchOnMount.always,
          staleDuration: const Duration(minutes: 3),
          retryCount: 1,
        ),
      ),
      child: const App()));
}

class App extends HookWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final profile = useQueryX<Profile, DioException>(
      ['profile'],
      jsonParser: (data) => Profile.fromJson(data),
      // onSuccess: (user, response) {
      //   authenticate();
      // },
      // onError: (error) {},
    );

    if (profile.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Watch((_) {
      final isLoggedIn = isAuthenticated();

      final router = GoRouter(
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (_, __) {
              return const HomeScreen(title: 'Flutter Demo Home Page');
            },
          ),
          GoRoute(
            path: '/profile',
            builder: (_, __) {
              return const ProfileScreen();
            },
            redirect: (context, state) {
              if (!isLoggedIn) return '/login';

              return null;
            },
          ),
          GoRoute(
            path: '/login',
            builder: (_, __) {
              return const LoginScreen();
            },
            redirect: (context, state) {
              if (isLoggedIn) return '/';

              return null;
            },
          ),
        ],
      );

      return MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
                TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              },
            )),
        routerConfig: router,
      );
    });
  }
}
