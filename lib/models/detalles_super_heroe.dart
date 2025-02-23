import 'package:personajes_marvel_app/models/super_heroe_thumbnail.dart';

class DetallesSuperHeroe {
  final String name;
  final SuperHeroeThumbnail thumbnail;
  final String descripcion;
  final List<String> comics;

  DetallesSuperHeroe({
    required this.name,
    required this.thumbnail,
    required this.comics,
    required this.descripcion,
  });

  factory DetallesSuperHeroe.fromMap(Map<String, dynamic> map) {
    final resultado = (map['results'] as List<dynamic>).first;
    return DetallesSuperHeroe(
      name: resultado['name'],
      thumbnail: SuperHeroeThumbnail.fromMap(resultado['thumbnail']),
      comics: List<String>.from(
        (resultado['comics']['items'] as List<dynamic>).map(
          (comic) {
            return comic['name'];
          },
        ),
      ),
      descripcion: resultado['description'],
    );
  }
}
