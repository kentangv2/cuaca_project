import 'package:NewsLine/ui/about_us/about.dart';
import 'package:NewsLine/ui/contact/contact.dart';
import 'package:NewsLine/ui/home.dart';
import 'package:NewsLine/ui/news/news.dart';
import 'package:NewsLine/ui/task/task.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() => runApp(CurvedBottomNavigationBarPage());

class CurvedBottomNavigationBarPage extends StatefulWidget {
  @override
  _CurvedBottomNavigationBarState createState() =>
      _CurvedBottomNavigationBarState();
}

class _CurvedBottomNavigationBarState
    extends State<CurvedBottomNavigationBarPage> {
  final navigationIcons = const [
    Icon(Icons.home),
    Icon(Icons.people),
    Icon(Icons.newspaper),
    Icon(Icons.note_alt),
    Icon(Icons.info_outline)
  ];
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          _selectedIndex == 0
          ?
          HomePage()
          :
          _selectedIndex == 1
          ?
          ContactListPage()
          :
          _selectedIndex == 2
          ?
          NewsPaper()
          :
          _selectedIndex == 3
          ?
          TaskListPage()
          :
          AboutPage()
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blue,
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        items: navigationIcons.map((icon) => icon).toList(),
      ),
    ));
  }
}