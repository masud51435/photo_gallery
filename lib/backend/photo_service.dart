import 'package:dio/dio.dart';
import 'package:image_gallery/backend/api_keys.dart';

class PhotoService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.unsplash.com/photos';

  Future<List<dynamic>> fetchPhotos({int page = 1}) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'client_id': ApiKeys,
          'page': page,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch photos: $e');
    }
  }
}
