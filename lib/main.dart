import 'package:flutter/material.dart';
import 'package:lunch_calculator/pages/EqualSplit.dart';
import 'package:lunch_calculator/pages/IndividualSplit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, primary: Colors.blueGrey),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const MainAPP(),
    );
  }
}

class MainAPP extends StatefulWidget {
  const MainAPP({super.key});

  @override
  State<MainAPP> createState() => _MainAPPState();
}

class _MainAPPState extends State<MainAPP> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    const EqualSplitTab(),
    const IndividualSplitTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'N분의 1 정산',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: '개별 정산',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
