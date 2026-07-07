import 'dart:io';
import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  final String filePath;

  const ImageDisplay({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(filePath),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Icon(Icons.broken_image, color: Colors.white54, size: 64),
        );
      },
    );
  }
}
