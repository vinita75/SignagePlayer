class ContentItem {
  final String type;
  final String url;
  String? localPath;

  ContentItem({
    required this.type,
    required this.url,
    this.localPath,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      type: json['type'] as String,
      url: json['url'] as String,
    );
  }

  bool get isVideo => type == 'video';

  bool get isDownloaded => localPath != null;
}
