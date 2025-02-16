class SuperHeroeThumbnail {
  final String path;
  final String fileExtension;

  SuperHeroeThumbnail({required this.path, required this.fileExtension});

  String get rutaCompleta {
    return '$path.$fileExtension';
  }

  factory SuperHeroeThumbnail.fromMap(Map<String, dynamic> data) {
    return SuperHeroeThumbnail(
      path: data['path'],
      fileExtension: data['extension'],
    );
  }
}
