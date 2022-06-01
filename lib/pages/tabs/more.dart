import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:space_herald/pages/planets/earth.dart';
import 'package:space_herald/pages/planets/jupiter.dart';
import 'package:space_herald/pages/planets/mars.dart';
import 'package:space_herald/pages/planets/planet_with_description.dart';
import 'package:animations/animations.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        //StretchingOverscrollIndicator(
        //  axisDirection: AxisDirection.down, child:
        children: [
          const SizedBox(height: 5),
          Card(
            shadowColor: Colors.transparent,
            elevation: 2,
            child: Container(
              margin: const EdgeInsets.all(6.0),
              child: FutureBuilder(
                future: http.get(
                  Uri.parse(
                      'https://raw.githubusercontent.com/dimstr/spacedata/main/info.txt'),
                ),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Интересный факт ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 25),
                        ),
                        Text(
                          snapshot.data!.body,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 23),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Text('error');
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Планеты солнечной системы',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                Text(
                  'Чтобы узнать подробнее о спутнике нажмите на её изображение',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/json/planets.json'),
              builder: (context, snapshot) {
                var data = json.decode(snapshot.data.toString());
                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 10 / 12,
                    ),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      // int divcount = data!.length - 1;
                      return OpenContainer(
                        transitionDuration: const Duration(milliseconds: 500),
                        closedColor: Colors.transparent,
                        closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        // openShape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(15.0),
                        // ),
                        openBuilder: (context, _) {
                          if (data[index]['name'] == 'Меркурий' ||
                              data[index]['name'] == 'Венера' ||
                              data[index]['name'] == 'Сатурн' ||
                              data[index]['name'] == 'Уран' ||
                              data[index]['name'] == 'Нептун') {
                            return PlanetInfo(
                              title: data[index]['name'],
                              path_to_big_image: data[index]['image'],
                              description: data[index]['description'],
                            );
                          } else if (data[index]['name'] == 'Земля') {
                            return const EarthPage();
                          } else if (data[index]['name'] == 'Марс') {
                            return const MarsPage();
                          } else if (data[index]['name'] == 'Юпитер') {
                            return const JupiterPage();
                          } else {
                            return Scaffold(
                              appBar: AppBar(
                                title: const Text('Ошибка!'),
                              ),
                              body: const Center(
                                child: Text(
                                  'Произошла ошибка! Мы уже работаем над этой проблемой.',
                                  style: TextStyle(fontSize: 40),
                                ),
                              ),
                            );
                          }
                        },
                        closedBuilder: (context, VoidCallback openContainer) {
                          return Card(
                            // GestureDetector(
                            // onTap: openContainer,
                            // child:
                            shadowColor: Colors.transparent,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    data[index]['image'],
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      data[index]['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // ),
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error');
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Некоторые спутники планет солнечной системы',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                Text(
                  'Чтобы узнать подробнее о планете нажмите на её изображение',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
