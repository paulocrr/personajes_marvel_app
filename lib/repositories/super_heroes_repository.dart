import 'package:fpdart/fpdart.dart';

import 'package:personajes_marvel_app/core/exceptions/error_desconocido.dart';
import 'package:personajes_marvel_app/core/exceptions/error_no_encontrado.dart';
import 'package:personajes_marvel_app/core/exceptions/error_parametros.dart';
import 'package:personajes_marvel_app/core/exceptions/error_servidor.dart';
import 'package:personajes_marvel_app/core/exceptions/error_sin_autorizacion.dart';
import 'package:personajes_marvel_app/core/exceptions/error_sin_coneccion.dart';
import 'package:personajes_marvel_app/core/failures/failures.dart';
import 'package:personajes_marvel_app/data_sources/marvel_api_data_source.dart';
import 'package:personajes_marvel_app/models/detalles_super_heroe.dart';
import 'package:personajes_marvel_app/models/lista_super_heroes.dart';

class SuperHeroesRepository {
  late MarvelApiDataSource marvelApiDataSource;
  final String _path = '/characters';

  SuperHeroesRepository() {
    marvelApiDataSource = MarvelApiDataSource();
  }

  Future<Either<Failure, ListaSuperHeroes>> obtenerSuperHeroes({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final resultado = await marvelApiDataSource.peticionGet(
        path: _path,
        parametros: {'offset': offset, 'limit': limit},
      );

      return Either.right(ListaSuperHeroes.fromMap(resultado));
    } on ErrorDesconocido {
      return Either.left(FallaDesconocida());
    } on ErrorParametros {
      return Either.left(FallaParametros());
    } on ErrorServidor {
      return Either.left(FallaServidor());
    } on ErrorSinAutorizacion {
      return Either.left(FallaDeAutorizacion());
    } on ErrorSinConeccion {
      return Either.left(FallaEnLaConeccion());
    }
  }

  Future<Either<Failure, DetallesSuperHeroe>> obtenerDetalleSuperHeroe(
      int id) async {
    try {
      final resultado = await marvelApiDataSource.peticionGet(
        path: '$_path/$id',
      );

      return Either.right(DetallesSuperHeroe.fromMap(resultado));
    } on ErrorDesconocido {
      return Either.left(FallaDesconocida());
    } on ErrorParametros {
      return Either.left(FallaParametros());
    } on ErrorServidor {
      return Either.left(FallaServidor());
    } on ErrorSinAutorizacion {
      return Either.left(FallaDeAutorizacion());
    } on ErrorSinConeccion {
      return Either.left(FallaEnLaConeccion());
    } on ErrorNoEncontrado {
      return Either.left(FallaNoEncontrado());
    }
  }
}
