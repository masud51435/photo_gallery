import 'package:hive/hive.dart';

part 'photo_model.g.dart';

@HiveType(typeId: 0)
class Photo extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String thumbnailUrl;

  @HiveField(2)
  final String fullImageUrl;

  Photo({
    required this.id,
    required this.thumbnailUrl,
    required this.fullImageUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      thumbnailUrl: json['urls']['thumb'],
      fullImageUrl: json['urls']['full'],
    );
  }
}
