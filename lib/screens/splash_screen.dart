import 'package:flutter/material.dart';

import '../models/content_item.dart';
import '../services/content_repository.dart';
import '../services/download_service.dart';
import 'playback_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ContentRepository _repository = ContentRepository();
  final DownloadService _downloadService = DownloadService();

  @override
  void initState() {
    super.initState();
    _prepareContentAndNavigate();
  }

  Future<void> _prepareContentAndNavigate() async {
    final List<ContentItem> items = await _repository.loadContentList();

    await _downloadService.downloadAll(items);

    final List<ContentItem> playableItems =
        items.where((item) => item.isDownloaded).toList();

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => PlaybackScreen(items: playableItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FlutterLogo(size: 120),
      ),
    );
  }
}
