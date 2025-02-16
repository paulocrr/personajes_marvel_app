import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:personajes_marvel_app/core/failures/failures.dart';
import 'package:personajes_marvel_app/models/super_heroe.dart';
import 'package:personajes_marvel_app/repositories/super_heroes_repository.dart';
import 'package:personajes_marvel_app/ui/mostrar_falla.dart';

class PantallaListaSuperHeroes extends StatefulWidget {
  const PantallaListaSuperHeroes({super.key});

  @override
  State<PantallaListaSuperHeroes> createState() =>
      _PantallaListaSuperHeroesState();
}

class _PantallaListaSuperHeroesState extends State<PantallaListaSuperHeroes> {
  List<SuperHeroe>? _listaSuperHeroes;
  Failure? _falla;
  final superHeroesRespository = SuperHeroesRepository();
  var estaCargando = false;

  @override
  void initState() {
    _obtenerSuperHeroes();
    super.initState();
  }

  void _obtenerSuperHeroes() async {
    setState(() {
      _listaSuperHeroes = null;
      _falla = null;
      estaCargando = true;
    });
    final superHeroesResultado = await superHeroesRespository
        .obtenerSuperHeroes(limit: 100);
    setState(() {
      superHeroesResultado.match(
        (falla) {
          _falla = falla;
        },
        (data) {
          _listaSuperHeroes = data.results;
        },
      );

      estaCargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (estaCargando == true) {
      return Scaffold(
        appBar: AppBar(title: Text('Lista de Super Heroes')),
        body: Center(child: SpinKitSquareCircle(color: Colors.red, size: 50.0)),
      );
    }

    if (_falla != null) {
      return MostrarFalla(
        falla: _falla!,
        reintentar: () {
          _obtenerSuperHeroes();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Lista de Super Heroes')),
      body: ListView.builder(
        itemCount: _listaSuperHeroes!.length,
        itemBuilder: (_, indice) {
          final superHeroe = _listaSuperHeroes![indice];
          final numeroDeOrden = indice + 1;
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(superHeroe.thumbnail.rutaCompleta),
            ),
            title: Text('#$numeroDeOrden ${superHeroe.name}'),
          );
        },
      ),
    );
  }
}
