import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_starter/hooks/use_query.dart';
import 'package:flutter_starter/models/collection_model.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final students = useQueryX<Collection, DioException>(['students?_limit=2'],
        jsonParser: (data) => Collection.fromJson(data));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                context.go('/profile');
              },
              child: const Text('Go to the Profile screen'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/login'),
              child: const Text('Go to the Login screen'),
            ),
            const Text('Home screen'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
