import 'package:flutter_starter/models/token_bulk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String accessTokenKey = "access_token";
  static const String refreshTokenKey = "refresh_token";

  static Future<void> storeTokens(TokenBulk tokenBulk) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, tokenBulk.accessToken);
    await prefs.setString(refreshTokenKey, tokenBulk.refreshToken);
  }

  static Future<TokenBulk> getTokens() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? '';
    final refreshToken = prefs.getString('refresh_token') ?? '';

    return TokenBulk(accessToken: accessToken, refreshToken: refreshToken);
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(accessTokenKey);
    await prefs.remove(refreshTokenKey);
  }
}
