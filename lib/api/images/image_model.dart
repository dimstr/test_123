class ImageModel {
  final String urlToImage;
  final String description;

  const ImageModel({
    required this.urlToImage,
    required this.description,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      urlToImage: json['urlToImage'] as String,
      description: json['description'] as String,
    );
  }
}
