import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'image_model.dart';


Future<List<ImageModel>> fetchImages(String url) async {
  final response = await http.get(Uri.parse(url));

  return compute(parseImages, response.body);
}

List<ImageModel> parseImages (String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ImageModel>((json) => ImageModel.fromJson(json)).toList();
}