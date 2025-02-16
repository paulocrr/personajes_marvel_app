import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:personajes_marvel_app/data_sources/marvel_api_data_source.dart';

void main() async {
  await dotenv.load();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final marvelApiDataSource = MarvelApiDataSource();

              final resultado = await marvelApiDataSource.peticionGet(
                path: '/characters',
                parametros: {'offset': 5},
              );
              print(resultado);
            },
            child: Text('test'),
          ),
        ),
      ),
    );
  }
}
