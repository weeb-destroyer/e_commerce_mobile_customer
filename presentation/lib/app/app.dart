import 'package:flutter/material.dart';

import 'widgets/navigation_bar.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomNavigationBar(
          selectedIndex: _selectedIndex,
          onTabSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: const [
          Center(
            child: Text('Home'),
          ),
          Center(
            child: Text('Favorites'),
          ),
          Center(
            child: Text('Vouchers'),
          ),
          Center(
            child: Text('Others'),
          )
        ][_selectedIndex]);
  }
}
