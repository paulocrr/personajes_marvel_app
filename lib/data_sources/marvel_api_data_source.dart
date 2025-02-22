import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:personajes_marvel_app/core/configs/configs.dart';
import 'package:personajes_marvel_app/core/exceptions/error_desconocido.dart';
import 'package:personajes_marvel_app/core/exceptions/error_no_encontrado.dart';
import 'package:personajes_marvel_app/core/exceptions/error_parametros.dart';
import 'package:personajes_marvel_app/core/exceptions/error_servidor.dart';
import 'package:personajes_marvel_app/core/exceptions/error_sin_autorizacion.dart';
import 'package:personajes_marvel_app/core/exceptions/error_sin_coneccion.dart';

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

    try {
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
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw ErrorSinConeccion();
      }

      final respuestaError = e.response;

      final codigoError = respuestaError?.statusCode ?? 500;

      if (codigoError == 401) {
        throw ErrorSinAutorizacion();
      } else if (codigoError == 404) {
        throw ErrorNoEncontrado();
      } else if (codigoError == 409) {
        throw ErrorParametros();
      } else if (codigoError >= 500) {
        throw ErrorServidor();
      } else {
        throw ErrorDesconocido();
      }
    }
  }
}
