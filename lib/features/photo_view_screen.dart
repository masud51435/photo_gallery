import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../model/photo_model.dart';

class PhotoViewScreen extends StatelessWidget {
  final Photo photo;
  final int index;

  const PhotoViewScreen({super.key, required this.photo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.download),
      //       onPressed: () {},
      //     )
      //   ],
      // ),
      body: Hero(
        tag: 'photo$index',
        child: PhotoView(
          imageProvider: NetworkImage(photo.fullImageUrl),
          minScale:
              PhotoViewComputedScale.contained, // Fit image within the screen
          maxScale: PhotoViewComputedScale.covered * 3.0, // Allow 3x zoom
          backgroundDecoration: BoxDecoration(
            color: Colors.black, // Match background with app theme
          ),
        ),
      ),
    );
  }
}
