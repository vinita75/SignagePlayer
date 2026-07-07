import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/content_item.dart';

class ContentRepository {
  static const String _assetPath = 'assets/content.json';

  Future<List<ContentItem>> loadContentList() async {
    final String jsonString = await rootBundle.loadString(_assetPath);
    final Map<String, dynamic> jsonData =
        json.decode(jsonString) as Map<String, dynamic>;
    final List<dynamic> results = jsonData['result'] as List<dynamic>;

    return results
        .map((dynamic e) => ContentItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
