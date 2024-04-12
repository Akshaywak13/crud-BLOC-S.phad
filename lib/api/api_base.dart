
import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

typedef ApiResponseSuccess = Function(dynamic data);
typedef ApiResponseFailure = Function(String error);

const String jsonContentType = 'application/json';

class ApiBase {
  final Map<String, String> _headers;
  // String? token =
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE3MDM4NDc1MzM0NjEsIm5hbWUiOiJWYWliaGF2IE5laGUiLCJ0ZW5hbnRJZCI6MTcwMzIyODMwMDQxNywicGhvbmVOdW1iZXIiOiI3MzUwMTAzMzQwIiwicm9sZSI6eyJyb2xlSWQiOjE3MDE0MjgzNjA3NTQsIm5hbWUiOiJhZG1pbiIsImNvZGUiOiJDRDIiLCJwZXJtaXNzaW9ucyI6WyJnZXQtYWxsIiwiTFNSIiwiT1NSIiwiQ1NSMiJdfSwiaWF0IjoxNzA0ODkxNjAzLCJleHAiOjE3MzU5OTU2MDN9.d2QEsh1gV5w4wJvkwsMGL92ycL-0RZOgAz-On8HBK0M';
  String? token = GetStorage().read("token");
  // Future _getToken() async {
  //   token = await '';
  // }

  ApiBase( {Map<String, String>? headers})
      : _headers = headers ?? {'Content-Type': jsonContentType};

  Future<void> get(
    String url,
    ApiResponseSuccess onSuccess,
    ApiResponseFailure onFailure, {
    bool? isTokenMandatory,
  }) async {
    if (isTokenMandatory ?? false) {
      _headers['Authorization'] = token ?? '';
    }
    _request(
        (uri) => http.get(uri, headers: _headers), url, onSuccess, onFailure);
  }

  Future<void> post(
    String url,
    Map<String, dynamic> body,
    ApiResponseSuccess onSuccess,
    ApiResponseFailure onFailure, {
    bool? isTokenMandatory,
  }) async {
    if (isTokenMandatory ?? false) {
      _headers['Authorization'] = token ?? '';
    }

    log("\x1B[35m${"Payload -> $body"}\x1B[0m");
    _request((uri) => http.post(uri, body: jsonEncode(body), headers: _headers),
        url, onSuccess, onFailure);
  }

  Future<void> put(
    String url,
    Map<String, dynamic> body,
    ApiResponseSuccess onSuccess,
    ApiResponseFailure onFailure, {
    bool? isTokenMandatory,
  }) async {
    if (isTokenMandatory ?? false) {
      _headers['Authorization'] = token ?? '';
    }
    log("\x1B[35m${"Payload -> $body"}\x1B[0m");
    _request((uri) => http.put(uri, body: jsonEncode(body), headers: _headers),
        url, onSuccess, onFailure);
  }

  Future<void> delete(
    String url,
    ApiResponseSuccess onSuccess,
    ApiResponseFailure onFailure, {
    bool? isTokenMandatory,
  }) async {
    if (isTokenMandatory ?? false) {
      _headers['Authorization'] = token ?? '';
    }
    _request((uri) => http.delete(uri, headers: _headers), url, onSuccess,
        onFailure);
  }

  Future<void> _request(Function requestMethod, String url,
      ApiResponseSuccess onSuccess, ApiResponseFailure onFailure) async {
    try {
      log("\x1B[37m${"URL -> $url"}\x1B[0m");
      final response = await requestMethod(
        Uri.parse(url),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        log("\x1B[32m${"Response Body -> ${response.body}"}\x1B[0m");
        onSuccess(jsonDecode(response.body));
      } else {
        final errorResponse = jsonDecode(response.body);
        final errorMessage = errorResponse['message'] ?? 'Failed to load data.';
        log("\x1B[31m${"Response Body -> $errorMessage"}\x1B[0m");

        switch (response.statusCode) {
          case 400:
            onFailure('Bad request: $errorMessage');
            break;
          case 401:
            onFailure('Unauthorized: $errorMessage');
            break;
          case 403:
            onFailure('Forbidden: $errorMessage');
            break;
          case 404:
            onFailure('Not found: $errorMessage');
            break;
          case 500:
            onFailure('Internal server error: $errorMessage');
            break;
          default:
            onFailure(
                'Failed to load data. Status code: ${response.statusCode}');
            break;
        }
      }
    } catch (e) {
      onFailure('An error occurred: $e');
    }
  }

  void addHeader(String key, String value) {
    _headers[key] = value;
  }

  String getHeader(String key) {
    return _headers[key] ?? "";
  }
}
