class MovieEntity {
  final String title;
  final String summary;
  final String image;
  final String premiered;
  final String status;
  final String averageRating;
  final List<String> genres;
  final String officialSite;

  MovieEntity({
    required this.title,
    required this.summary,
    required this.image,
    required this.premiered,
    required this.status,
    required this.averageRating,
    required this.genres,
    required this.officialSite,
  });

  factory MovieEntity.fromJson(Map<String, dynamic> json) {
    return MovieEntity(
      title: json['name'],
      summary: json['summary'] ?? 'No summary available',
      image: json['image']?['medium'] ?? '', // Fallback for no image
      premiered: json['premiered'] ?? 'N/A',
      status: json['status'] ?? 'N/A',
      averageRating: json['rating']?['average']?.toString() ?? 'N/A',
      genres: List<String>.from(json['genres'] ?? []),
      officialSite: json['officialSite'] ?? '',
    );
  }
}
