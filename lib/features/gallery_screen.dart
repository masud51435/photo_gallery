import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:image_gallery/controller/photo_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'photo_view_screen.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PhotoController controller = Get.put(PhotoController());

    return Scaffold(
      body: Obx(
        () {
          if (controller.isLoading.value && controller.photos.isEmpty) {
            return Center(
              child: LoadingAnimationWidget.progressiveDots(
                color: Colors.deepPurple,
                size: 50,
              ),
            );
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
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text('Image Gallery'),
                  floating: true,
                  snap: true,
                  toolbarHeight: 50,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverGrid(
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
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return InkWell(
                          onTap: () => Get.to(
                            () => PhotoViewScreen(
                              photo: controller.photos[index],
                              index: index,
                            ),
                          ),
                          child: Hero(
                            tag: 'photo$index',
                            child: CachedNetworkImage(
                              imageUrl: controller.photos[index].thumbnailUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[200]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.grey[200],
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        );
                      },
                      childCount: controller.photos.length,
                    ),
                  ),
                ),
                if (controller.isLoading.value)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.deepPurple.shade100,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
