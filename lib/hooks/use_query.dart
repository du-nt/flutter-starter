import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_starter/services/api_service.dart';
import 'package:fquery/fquery.dart';

UseQueryResult<TData, TError> useQueryX<TData, TError>(
  List<dynamic> queryKey, {
  bool enabled = true,
  RefetchOnMount? refetchOnMount,
  Duration? staleDuration,
  Duration? cacheDuration,
  Duration? refetchInterval,
  int? retryCount,
  Duration retryDelay = const Duration(seconds: 1, milliseconds: 500),
  Options? config,
  Function(TData data, Response<dynamic> response)? onSuccess,
  Function(TError error)? onError,
  Future<TData> Function()? fetcher,
  TData Function(dynamic data)? jsonParser,
}) {
  final retryCountRef = useRef<int>(0);

  if (fetcher != null) {
    return useQuery<TData, TError>(queryKey, fetcher,
        enabled: enabled,
        refetchOnMount: refetchOnMount,
        staleDuration: staleDuration,
        cacheDuration: cacheDuration,
        refetchInterval: refetchInterval,
        retryCount: retryCount,
        retryDelay: retryDelay);
  }

  if (jsonParser == null) {
    throw ArgumentError(
        'jsonParser cannot be null if fetcher is not provided.');
  }

  Future<TData> defaultFetcher() async {
    try {
      retryCountRef.value++;

      final String url = queryKey[0];
      final response = await diox.request(url,
          options: Options(
            method: config?.method ?? 'GET',
          ));

      final TData data = jsonParser(response.data);

      if (onSuccess != null) onSuccess(data, response);

      return data;
    } catch (error) {
      // if (retryCountRef.value >= retryCount) {
      //   retryCountRef.value = 0;

      //   if (onError != null) {
      //     onError(error as TError);
      //   }
      // }

      rethrow;
    }
  }

  return useQuery<TData, TError>(queryKey, defaultFetcher,
      enabled: enabled,
      refetchOnMount: refetchOnMount,
      staleDuration: staleDuration,
      cacheDuration: cacheDuration,
      refetchInterval: refetchInterval,
      retryCount: retryCount,
      retryDelay: retryDelay);
}
