import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_starter/stores/user.store.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => context.push('/'),
              child: const Text('Go to the Home screen'),
            ),
            ElevatedButton(
              onPressed: () {
                authenticate();
              },
              child: const Text('Login'),
            ),
            const Text('Login screen'),
          ],
        ),
      ),
    );
  }
}
