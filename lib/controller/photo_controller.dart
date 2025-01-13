import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../backend/photo_service.dart';
import '../model/photo_model.dart';

class PhotoController extends GetxController {
  final PhotoService _photoService = PhotoService();
  final RxList<Photo> photos = <Photo>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt currentPage = 1.obs;

  late Box<Photo> _photoBox;

  @override
  void onInit() {
    super.onInit();
    _photoBox = Hive.box<Photo>('photos');
    _loadCachedPhotos();
    fetchPhotos();
  }

  void _loadCachedPhotos() {
    // Load cached photos from Hive
    final cachedPhotos = _photoBox.values.toList();
    photos.addAll(cachedPhotos);
  }

  void fetchPhotos() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      final data = await _photoService.fetchPhotos(page: currentPage.value);

      // Map fetched data to Photo objects
      final newPhotos = data.map((e) => Photo.fromJson(e)).toList();

      // Add to Hive cache
      for (var photo in newPhotos) {
        _photoBox.put(photo.id, photo);
      }

      // Update the observable list
      photos.addAll(newPhotos);
      currentPage.value++;
    } catch (e) {
      print("Error fetching photos: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
