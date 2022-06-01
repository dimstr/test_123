import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'news_model.dart';


Future<List<News>> fetchNews() async {
  final response = await http.get(Uri.parse('https://raw.githubusercontent.com/dimstr/spacedata/main/news.json'));

  return compute(parseNews, response.body);
}

List<News> parseNews (String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<News>((json) => News.fromJson(json)).toList();
}