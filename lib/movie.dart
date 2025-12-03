class Movie {
  final int id;
  final String title;
  final int year;
  final String genre;
  final String poster;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.genre,
    required this.poster,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      year: json['year'] as int,
      genre: json['genre'] as String,
      poster: json['poster'] as String,
    );
  }
}
