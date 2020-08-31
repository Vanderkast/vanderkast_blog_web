import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:vanderkast_blog_web/web/controller/url.dart';

class DioKeeper {
  Dio _dio;

  DioKeeper() {
    _dio = new Dio(BaseOptions(baseUrl: url()));

    if (!kIsWeb)
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
  }

  Dio get dio => _dio;
}

class HttpExecutor {
  final DioKeeper _dioKeeper;

  HttpExecutor(this._dioKeeper);

  /// http method GET
  Future<Response> get(String path,
          {Map<String, dynamic> data, ContentType contentType}) =>
      request(path, "GET", data, contentType: contentType ?? ContentType.json);

  /// http method POST
  Future<Response> post(String path, Map<String, dynamic> data) =>
      request(path, "POST", data);

  /// http method PUT
  Future<Response> put(String path, Map<String, dynamic> data) =>
      request(path, "PUT", data);

  /// http method DELETE
  Future<Response> delete(String path, Map<String, dynamic> data) =>
      request(path, "DELETE", data);

  /// core request
  /// all other method's are syntax sugar for this method
  Future<Response> request(
      String path, String method, Map<String, dynamic> data,
      {ContentType contentType}) async {
    return _dioKeeper.dio.request(
      path,
      data: data,
      options:
          await _options(method, contentType: contentType ?? ContentType.json),
    );
  }

  /// adds Bearer access token to http request headers
  Future<Options> _options(String method, {ContentType contentType}) async =>
      Options(
        method: method,
        contentType: (contentType ?? ContentType.json).toString(),
      );
}
