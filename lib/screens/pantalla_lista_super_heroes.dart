import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:personajes_marvel_app/models/super_heroe.dart';
import 'package:personajes_marvel_app/repositories/super_heroes_repository.dart';

class PantallaListaSuperHeroes extends StatefulWidget {
  const PantallaListaSuperHeroes({super.key});

  @override
  State<PantallaListaSuperHeroes> createState() =>
      _PantallaListaSuperHeroesState();
}

class _PantallaListaSuperHeroesState extends State<PantallaListaSuperHeroes> {
  final superHeroesRespository = SuperHeroesRepository();
  var estaCargando = false;
  final _pagingController = PagingController<int, SuperHeroe>(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _obtenerSuperHeroes(pageKey);
    });
    super.initState();
  }

  void _obtenerSuperHeroes(int pageKey) async {
    final limit = 15;
    final offset = (pageKey - 1) * limit;
    final superHeroesResultado = await superHeroesRespository
        .obtenerSuperHeroes(limit: limit, offset: offset);
    superHeroesResultado.fold((falla) {
      _pagingController.error = falla;
    }, (listaSuperHeroes) {
      final esPaginaFinal = listaSuperHeroes.results.length < limit;
      if (esPaginaFinal) {
        _pagingController.appendLastPage(listaSuperHeroes.results);
      } else {
        _pagingController.appendPage(listaSuperHeroes.results, pageKey + 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Super Heroes')),
      body: PagedListView<int, SuperHeroe>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          animateTransitions: true,
          itemBuilder: (_, superHeroe, indice) {
            final numeroDeOrden = indice + 1;
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                    superHeroe.thumbnail.rutaCompleta),
              ),
              title: Text('#$numeroDeOrden ${superHeroe.name}'),
            );
          },
        ),
      ),
    );
  }
}
