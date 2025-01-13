import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';

import '../model/photo_model.dart';

class PhotoViewScreen extends StatefulWidget {
  final Photo photo;
  final int index;

  const PhotoViewScreen({super.key, required this.photo, required this.index});

  @override
  State<PhotoViewScreen> createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  double _progress = 0.0;
  bool _isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: 'photo${widget.index}',
            child: PhotoView(
              imageProvider: NetworkImage(widget.photo.fullImageUrl),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 3.0,
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 0,
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: () async {
                    await Share.share(widget.photo.fullImageUrl);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const CircleBorder(),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.share, color: Colors.white),
                ),
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const CircleBorder(),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            left: 10,
            child: OutlinedButton(
              onPressed: _isDownloading ? null : () => _downloadPhoto(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white, width: 2),
              ),
              child: _isDownloading
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CircularProgressIndicator(
                            value: _progress,
                            strokeWidth: 2,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        ),
                        Text(
                          "${(_progress * 100).toStringAsFixed(0)}%",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ],
                    )
                  : const Text('Download Now',
                      style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadPhoto(BuildContext context) async {
    setState(() {
      _isDownloading = true;
      _progress = 0.0;
    });

    try {
      if (await Permission.storage.request().isGranted ||
          await Permission.photos.request().isGranted) {
        final dio = Dio();
        final tempDir = await getTemporaryDirectory();
        final tempFilePath = "${tempDir.path}/unsplash_${widget.photo.id}.jpg";

        await dio.download(
          widget.photo.fullImageUrl,
          tempFilePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              setState(() {
                _progress = received / total;
              });
            }
          },
        );

        final bytes = await File(tempFilePath).readAsBytes();

        final result = await ImageGallerySaverPlus.saveImage(
          Uint8List.fromList(bytes),
          quality: 100,
          name: "unsplash_${widget.photo.id}",
        );

        if (result['isSuccess'] == true && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Photo saved successfully')),
          );
        } else {
          throw Exception("Failed to save photo");
        }
      } else {
        if (await Permission.storage.request().isPermanentlyDenied) {
          openAppSettings();
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Storage permission is required')),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save photo: $e')),
        );
      }
    } finally {
      setState(() {
        _isDownloading = false;
        _progress = 0.0;
      });
    }
  }
}
