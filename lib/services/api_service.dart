import 'package:dio/dio.dart';
import 'package:flutter_starter/models/token_bulk.dart';
import 'package:flutter_starter/utils/token_storage.dart';

final Dio diox = Dio(BaseOptions(
  baseUrl: 'https://js-post-api.herokuapp.com/api/',
  headers: {'Content-Type': 'application/json'},
))
  ..interceptors.add(QueuedInterceptorsWrapper(
    onRequest: (options, handler) async {
      final TokenBulk tokens = await TokenStorage.getTokens();

      options.headers['Authorization'] = "Bearer ${tokens.accessToken}";
      return handler.next(options);
    },
    onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        try {
          final String newAccessToken = await refreshToken();

          final RequestOptions retryRequest = error.requestOptions;
          retryRequest.headers['Authorization'] = 'Bearer $newAccessToken';

          final retryResponse = await diox.fetch(error.requestOptions);

          return handler.resolve(retryResponse);
        } catch (e) {
          return handler.reject(error);
        }
      }

      return handler.next(error);
    },
  ));

Future<String> refreshToken() async {
  try {
    final TokenBulk tokens = await TokenStorage.getTokens();

    final response = await Dio().post(
      '${diox.options.baseUrl}token/refresh',
      data: {"refreshToken": tokens.refreshToken},
    );

    final newTokens = TokenBulk.fromJson(response.data);

    await TokenStorage.storeTokens(newTokens);
    return newTokens.accessToken;
  } catch (e) {
    rethrow;
  }
}
