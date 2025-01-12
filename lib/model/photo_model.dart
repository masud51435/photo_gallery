class Photo {
  final String id;
  final String thumbnailUrl;
  final String fullImageUrl;

  Photo({required this.id, required this.thumbnailUrl, required this.fullImageUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      thumbnailUrl: json['urls']['thumb'],
      fullImageUrl: json['urls']['full'],
    );
  }
}
