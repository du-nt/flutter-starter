import 'package:flutter_starter/utils/token_storage.dart';
import 'package:signals/signals.dart';

final isAuthenticated = signal(false);

void authenticate() async {
  isAuthenticated.value = true;
}

void unAuthenticate() {
  isAuthenticated.value = false;
  TokenStorage.clearTokens();
}
