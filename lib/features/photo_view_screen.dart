import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../model/photo_model.dart';

class PhotoViewScreen extends StatelessWidget {
  final Photo photo;
  final int index;

  const PhotoViewScreen({super.key, required this.photo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: 'photo$index',
            child: PhotoView(
              imageProvider: NetworkImage(photo.fullImageUrl),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 3.0,
              backgroundDecoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 10,
            child: OutlinedButton(
              onPressed: () {
                Get.back();
              },
              style: OutlinedButton.styleFrom(
                shape: const CircleBorder(),
                side: const BorderSide(color: Colors.white, width: 2),
              ),
              child: Icon(Icons.close, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            left: 10,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white, width: 2),
              ),
              child:
                  Text('Download Now', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
