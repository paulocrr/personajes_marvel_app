import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:personajes_marvel_app/repositories/super_heroes_repository.dart';
import 'package:personajes_marvel_app/ui/mostrar_falla.dart';

class PantallaDetallesSuperHeroe extends StatelessWidget {
  final SuperHeroesRepository _superHeroesRepository;
  PantallaDetallesSuperHeroe({super.key})
      : _superHeroesRepository = SuperHeroesRepository();

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as int?;

    if (id == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detalles'),
        ),
        body: Center(
          child: Text('Error se necesita un id para cargar los detalles'),
        ),
      );
    }

    return FutureBuilder(
      future: _superHeroesRepository.obtenerDetalleSuperHeroe(id),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.match((f) {
            return MostrarFalla(falla: f);
          }, (superHeroe) {
            return Scaffold(
              appBar: AppBar(title: Text('Detalles')),
              body: ListView(
                children: [
                  CachedNetworkImage(
                      imageUrl: superHeroe.thumbnail.rutaCompleta)
                ],
              ),
            );
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Cargando'),
          ),
          body: Center(
            child: SpinKitDualRing(color: Colors.red),
          ),
        );
      },
    );
  }
}
