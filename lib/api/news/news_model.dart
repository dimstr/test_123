class News {
  final String title;
  final String urlToImage;
  final String type;
  final String urlToMarkdown;
  final String urlToWeb;

  const News({
    required this.title,
    required this.urlToImage,
    required this.type,
    required this.urlToMarkdown,
    required this.urlToWeb,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] as String,
      urlToImage: json['urlToImage'] as String,
      type: json['type'] as String,
      urlToMarkdown: json['urlToMarkdown'] as String,
      urlToWeb: json['urlToWeb'] as String,
    );
  }
}
