import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../api/news/news_model.dart';
import 'detail.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key, required this.news}) : super(key: key);

  final List<News> news;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // StretchingOverscrollIndicator(
      // axisDirection: AxisDirection.down,
      // child:
      itemCount: news.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          child: Card(
            shadowColor: Colors.transparent,
            elevation: 1,
            child: InkWell(
              onTap: () {
                showBarModalBottomSheet(
                  // duration: const Duration(milliseconds: 400),
                  context: context,
                  builder: (context) => Scaffold(
                    body: DetailPage(
                      type: news[index].type,
                      urlToMarkdown: news[index].urlToMarkdown,
                      urlToWeb: news[index].urlToWeb,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      news[index].urlToImage,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 9),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      news[index].title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 9),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
