import 'package:dio/dio.dart';

import '../configuration/GlobalConfiguration.dart';

class RequestUtil {

  RequestUtil._();

  static late final Dio _dio;

  static bool _isInitialized = false;

  static void init({
    String? baseUrl,
    int? timeout,
    List<Interceptor>? interceptors,
  }) {
    if (_isInitialized) return;

    final options = BaseOptions(
      baseUrl: baseUrl ?? GlobalConfiguration.baseUrl,
      connectTimeout: Duration(milliseconds: timeout ?? GlobalConfiguration.connectTimeout),
      receiveTimeout: Duration(milliseconds: timeout ?? GlobalConfiguration.receiveTimeout),
      contentType: 'application/json; charset=utf-8',
    );

    _dio = Dio(options);

    if (interceptors != null && interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }

    _isInitialized = true;
  }

  static Future<T?> request<T>(
      String path, {
        String method = 'GET',
        dynamic data,
        Map<String, dynamic>? query,
        Options? options,
      }) async {

    assert(_isInitialized, "在使用 RequestUtil 之前必须先调用 init()");

    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: query,
        options: options?.copyWith(method: method) ?? Options(method: method),
      );
      return response.data as T?;
    } catch (e) {

      rethrow;
    }
  }

  static Future<T?> get<T>(String path, {Map<String, dynamic>? query}) =>
      request<T>(path, method: 'GET', query: query);

  static Future<T?> post<T>(String path, {dynamic data}) =>
      request<T>(path, method: 'POST', data: data);
}