import 'package:personajes_marvel_app/models/super_heroe.dart';

class ListaSuperHeroes {
  final int offset;
  final int limit;
  final int total;
  final int count;

  final List<SuperHeroe> results;

  ListaSuperHeroes({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  factory ListaSuperHeroes.fromMap(Map<String, dynamic> data) {
    return ListaSuperHeroes(
      offset: data['offset'],
      limit: data['limit'],
      total: data['total'],
      count: data['count'],
      results: List.from(
        (data['results'] as List<dynamic>).map((superheroe) {
          return SuperHeroe.fomMap(superheroe);
        }),
      ),
    );
  }
}
