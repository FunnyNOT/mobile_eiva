import 'package:flutter/material.dart';
import 'package:eiva/home.dart';
import 'package:eiva/settings.dart';

enum NavBarItems { home, settings }

class MyNavigationBar extends StatefulWidget {
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  NavBarItems _selectedItem = NavBarItems.home;

  Widget _getScreen(NavBarItems item) {
    switch (item) {
      case NavBarItems.home:
        return const HomePage(); // replace with your Home screen
      case NavBarItems.settings:
        return const SettingsPage(); // replace with your Settings screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _getScreen(_selectedItem)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedItem.index,
        onTap: (index) {
          setState(() {
            _selectedItem = NavBarItems.values[index];
          });
        },
      ),
    );
  }
}
