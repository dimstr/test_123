import 'package:flutter/material.dart';
import '../pages/tabs/news.dart';
import '../pages/tabs/more.dart';
import '../pages/tabs/photo_of_the_day.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List pages = const [
    News(),
    More(),
    PhotoOfTheDay(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 60,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.newspaper_outlined),
            label: 'Новости',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            label: 'Информация',
          ),
          NavigationDestination(
            icon: Icon(Icons.photo_outlined),
            label: 'Фото дня',
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) =>
            setState(() => _selectedIndex = index),
      ),
    );
  }
}
