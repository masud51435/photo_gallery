import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:image_gallery/controller/photo_controller.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PhotoController controller = Get.put(PhotoController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gallery'),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value && controller.photos.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.pixels ==
                      scrollNotification.metrics.maxScrollExtent &&
                  !controller.isLoading.value) {
                controller.fetchPhotos();
              }
              return false;
            },
            child: GridView.custom(
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                pattern: [
                  const QuiltedGridTile(1, 2),
                  const QuiltedGridTile(2, 1),
                  const QuiltedGridTile(2, 1),
                  const QuiltedGridTile(1, 1),
                  const QuiltedGridTile(1, 1),
                  const QuiltedGridTile(2, 1),
                  const QuiltedGridTile(1, 2),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                childCount: controller.photos.length,
                (context, index) => CachedNetworkImage(
                  imageUrl: controller.photos[index].thumbnailUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
