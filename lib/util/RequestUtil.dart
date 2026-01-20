import 'package:dio/dio.dart';

class RequestUtil {
  final Dio _dio;

  RequestUtil({
    required String baseUrl,
    int timeout = 10000,
    List<Interceptor>? interceptors,
  }) : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: Duration(milliseconds: timeout),
    receiveTimeout: Duration(milliseconds: timeout),
    contentType: 'application/json; charset=utf-8',
  )) {
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  Future<dynamic> request(
      String path, {
        String method = 'GET',
        dynamic data,
        Map<String, dynamic>? query,
      }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: query,
        options: Options(method: method),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) =>
      request(path, method: 'GET', query: query);

  Future<dynamic> post(String path, {dynamic data}) =>
      request(path, method: 'POST', data: data);
}