import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'package:space_vestnik/pages/planets/earth_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

class EarthPage extends StatefulWidget {
  const EarthPage({Key? key}) : super(key: key);

  @override
  State<EarthPage> createState() => _EarthPageState();
}

class _EarthPageState extends State<EarthPage> {
  @override
  void initState() {
    super.initState();

    if (kIsWeb) WebView.platform = WebWebViewPlatform();
  }

  Widget page = const CircularProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Земля'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset('assets/images/earth.jpg'),
            ),
            const Text(
              'Земля',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 5),
            Card(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: Text(
                        'Посмотрите на Землю в прямом эфире!',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Flexible(
                      child: OpenContainer(
                        closedColor: Colors.transparent,
                        closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        // openShape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(20.0),
                        // ),
                        transitionDuration: const Duration(milliseconds: 800),
                        closedBuilder: (context, VoidCallback openContainer) {
                          return ElevatedButton(
                            child: const Text('Смотреть'),
                            onPressed: openContainer,
                          );
                        },
                        openBuilder: (context, _) {
                          Timer(
                            const Duration(milliseconds: 700),
                            () {
                              setState(() {
                                page = const WebView(
                                  initialUrl:
                                      'https://dimstr.github.io/EarthOnLive/',
                                );
                              });
                            },
                          );

                          return Scaffold(
                            appBar: AppBar(),
                            body: Center(
                              child: page,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Text('Описание'),
          ],
        ),
      ),
    );
  }
}
