import 'package:flutter/material.dart';
import 'package:space_vestnik/pages/utils/newsList.dart';
import '../../api/news/fetch_news.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchNews(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Произошла ошибка'),
          );
        } else if (snapshot.hasData) {
          return Center(
            child: NewsList(
              news: snapshot.data!,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
