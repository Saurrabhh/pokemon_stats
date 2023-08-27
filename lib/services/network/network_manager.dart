import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pokemon_stats/constants/typedefs.dart';
import 'package:pokemon_stats/models/failure.dart';
import 'package:pokemon_stats/models/network/network_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../constants/api_constants.dart';
import '../../models/network/network_request.dart';

class NetworkManager {
  static final NetworkManager instance = NetworkManager();

  final Dio _dio = Dio();

  NetworkManager() {
    _configureDio();
  }

  void _configureDio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);

    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: false,
      responseBody: false,
      responseHeader: false,
      compact: false,
    ));
  }

  FutureEitherApiResponse perform(NetworkRequest request) async {
    try {
      final response = await _dio.request<Map<String, dynamic>>(
        request.url,
        data: request.body,
        queryParameters: request.queryParams,
        options: _getOptions(request),
      );
      return Either.right(ApiSuccess(data: response.data ?? {}));
    } catch (e) {
      return Either.left(Failure(errorMsg: e.toString()));
    }
  }

  Options _getOptions(NetworkRequest request) {
    return Options(
      headers: {"Accept": "application/json", ...?request.headers},
      method: request.requestMethod.name,
    );
  }
}
