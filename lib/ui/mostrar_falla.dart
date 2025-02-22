import 'package:flutter/material.dart';
import 'package:personajes_marvel_app/core/failures/failures.dart';

class MostrarFalla extends StatelessWidget {
  final Failure falla;
  final VoidCallback? reintentar;
  const MostrarFalla({required this.falla, this.reintentar, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ocurrio un error')),
      body: Center(
        child: Column(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(falla.mesanje, style: TextStyle(fontSize: 24)),
            if (reintentar != null)
              ElevatedButton(
                onPressed: () {
                  reintentar?.call();
                },
                child: Text('Reintentar'),
              ),
          ],
        ),
      ),
    );
  }
}
