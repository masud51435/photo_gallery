import 'package:get/get.dart';

import '../backend/photo_service.dart';
import '../model/photo_model.dart';


class PhotoController extends GetxController {
  final PhotoService _photoService = PhotoService();
  final RxList<Photo> photos = <Photo>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt currentPage = 1.obs;

  @override
  void onInit() {
    fetchPhotos();
    super.onInit();
  }

  void fetchPhotos() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      final data = await _photoService.fetchPhotos(page: currentPage.value);
      photos.addAll(data.map((e) => Photo.fromJson(e)).toList());
      currentPage.value++;
    } catch (e) {
      print("Error fetching photos: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
