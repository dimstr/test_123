import 'package:flutter/material.dart';

import '../../api/images/fetch_news.dart';
import '../utils/grid_images.dart';

class JupiterPage extends StatefulWidget {
  const JupiterPage({Key? key}) : super(key: key);

  @override
  State<JupiterPage> createState() => _JupiterPageState();
}

class _JupiterPageState extends State<JupiterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Юпитер'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset('assets/images/jupiter.jpg'),
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
                          'https://raw.githubusercontent.com/dimstr/spacedata/main/images/jupiter.json'),
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
