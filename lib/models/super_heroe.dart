import 'package:personajes_marvel_app/models/super_heroe_thumbnail.dart';

class SuperHeroe {
  final int id;
  final String name;
  final SuperHeroeThumbnail thumbnail;

  SuperHeroe({required this.id, required this.name, required this.thumbnail});

  factory SuperHeroe.fomMap(Map<String, dynamic> data) {
    return SuperHeroe(
      id: data['id'],
      name: data['name'],
      thumbnail: SuperHeroeThumbnail.fromMap(data['thumbnail']),
    );
  }
}
