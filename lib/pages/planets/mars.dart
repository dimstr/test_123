import 'package:flutter/material.dart';
import 'package:space_herald/api/images/fetch_news.dart';
import 'package:space_herald/pages/utils/grid_images.dart';

class MarsPage extends StatefulWidget {
  const MarsPage({Key? key}) : super(key: key);

  @override
  State<MarsPage> createState() => _MarsPageState();
}

class _MarsPageState extends State<MarsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Марс'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset('assets/images/mars.png'),
            ),
            const Text(
              'Марс',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const Text('Описание'),
            Card(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                // padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    const Text(
                      'Галерея фотографий с марса',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    FutureBuilder(
                      future: fetchImages(
                          'https://raw.githubusercontent.com/dimstr/spacedata/main/images/mars.json'),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Произошла ошибка'),
                          );
                        } else if (snapshot.hasData) {
                          return Center(
                            child: GridImages(
                              data: snapshot.data!,
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
