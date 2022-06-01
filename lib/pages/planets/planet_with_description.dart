import 'package:flutter/material.dart';

class PlanetInfo extends StatelessWidget {
  const PlanetInfo({
    Key? key,
    required this.title,
    required this.path_to_big_image,
    required this.description,
  }) : super(key: key);

  final String title;
  final String path_to_big_image;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(path_to_big_image),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 5),
                Text(description)
              ],
            ),
          ),
        ));
  }
}
