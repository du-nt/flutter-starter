import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_starter/configs/router_config.dart';
import 'package:flutter_starter/hooks/use_query.dart';
import 'package:flutter_starter/models/profile_model.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:fquery/fquery.dart';

void main() {
  // Turn off the # in the URLs on the web
  usePathUrlStrategy();

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

    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: routerConfig,
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
    );
  }
}
