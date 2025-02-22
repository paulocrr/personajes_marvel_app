import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:personajes_marvel_app/routes/routes.dart';
import 'package:personajes_marvel_app/screens/pantalla_detalles_super_heroe.dart';
import 'package:personajes_marvel_app/screens/pantalla_lista_super_heroes.dart';

void main() async {
  await dotenv.load();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.home,
      routes: {
        Routes.home: (_) => PantallaListaSuperHeroes(),
        Routes.detallesHeroe: (_) => PantallaDetallesSuperHeroe(),
      },
    );
  }
}
