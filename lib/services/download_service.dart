import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../models/content_item.dart';

class DownloadService {
  static const Duration _downloadTimeout = Duration(seconds: 30);

  Future<void> downloadAll(List<ContentItem> items) async {
    final Directory dir = await getApplicationDocumentsDirectory();

    await Future.wait(
      items.asMap().entries.map(
            (entry) => _downloadItem(
              item: entry.value,
              index: entry.key,
              directoryPath: dir.path,
            ),
          ),
    );
  }

  Future<void> _downloadItem({
    required ContentItem item,
    required int index,
    required String directoryPath,
  }) async {
    try {
      final String extension = item.isVideo ? 'mp4' : 'jpg';
      final String filePath = '$directoryPath/content_$index.$extension';
      final File file = File(filePath);

      final http.Response response = await http
          .get(Uri.parse(item.url))
          .timeout(_downloadTimeout);

      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        item.localPath = filePath;
      } else {
        print('Download failed (${response.statusCode}) for ${item.url}');
      }
    } catch (e) {
      print('Error downloading ${item.url}: $e');
    }
  }
}
