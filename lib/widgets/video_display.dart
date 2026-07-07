import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDisplay extends StatefulWidget {
  final String filePath;

  const VideoDisplay({super.key, required this.filePath});

  @override
  State<VideoDisplay> createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  late final VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.file(File(widget.filePath));
    try {
      await _controller.initialize();
      if (!mounted) return;
      setState(() => _isInitialized = true);
      await _controller.setLooping(false);
      await _controller.play();
    } catch (e) {
      if (!mounted) return;
      setState(() => _hasError = true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return const Center(
        child: Icon(Icons.error_outline, color: Colors.white54, size: 64),
      );
    }

    if (!_isInitialized) {
      return const SizedBox.shrink();
    }

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: _controller.value.size.width,
        height: _controller.value.size.height,
        child: VideoPlayer(_controller),
      ),
    );
  }
}
