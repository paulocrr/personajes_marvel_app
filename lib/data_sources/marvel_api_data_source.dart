import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:personajes_marvel_app/configs/configs.dart';

class MarvelApiDataSource {
  late Dio _dio;

  MarvelApiDataSource() {
    _dio = Dio(BaseOptions(baseUrl: 'http://gateway.marvel.com/v1/public'));
  }

  Future<Map<String, dynamic>> peticionGet({
    required String path,
    Map<String, dynamic> parametros = const {},
  }) async {
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final publicKey = Configs.publicKey;
    final privateKey = Configs.privateKey;
    final cadenaDeAutorizacion = '$timestamp$privateKey$publicKey';

    final cadenaEnBytes = utf8.encode(cadenaDeAutorizacion);
    final hash = md5.convert(cadenaEnBytes).toString();

    final resultado = await _dio.get(
      path,
      queryParameters: {
        'ts': timestamp,
        'apikey': publicKey,
        'hash': hash,
        ...parametros,
      },
    );

    return resultado.data['data'];
  }
}
