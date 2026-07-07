import 'dart:async';

import 'package:flutter/material.dart';

import '../models/content_item.dart';
import '../widgets/image_display.dart';
import '../widgets/video_display.dart';


class PlaybackScreen extends StatefulWidget {
  final List<ContentItem> items;

  const PlaybackScreen({super.key, required this.items});

  @override
  State<PlaybackScreen> createState() => _PlaybackScreenState();
}

class _PlaybackScreenState extends State<PlaybackScreen> {
  static const Duration _displayDuration = Duration(seconds: 10);

  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.items.isNotEmpty) {
      _scheduleNext();
    }
  }

  void _scheduleNext() {
    _timer?.cancel();
    _timer = Timer(_displayDuration, _advanceToNextItem);
  }

  void _advanceToNextItem() {
    if (!mounted) return;
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.items.length;
    });
    _scheduleNext();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'No content available',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    final ContentItem currentItem = widget.items[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: currentItem.isVideo
            ? VideoDisplay(
                key: ValueKey(currentItem.localPath),
                filePath: currentItem.localPath!,
              )
            : ImageDisplay(
                key: ValueKey(currentItem.localPath),
                filePath: currentItem.localPath!,
              ),
      ),
    );
  }
}
