import 'package:flutter/material.dart';
import 'package:lunch_calculator/common/layout.dart';
import 'package:lunch_calculator/dutchPay.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, primary: Colors.blue[600]),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const MyHomeApp(),
    );
  }
}

class MyHomeApp extends StatefulWidget {
  const MyHomeApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: '오늘 점심 얼마??',
      icon: const Icon(
        Icons.fastfood,
        size: 30.0,
        color: Colors.black,
      ),
      custom: [
        Row(
          children: [
            const SizedBox(width: 4.0),
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const DutchPay()));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue[600],
                      shape: RoundedRectangleBorder(
                          //모서리를 둥글게
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text(
                      '더치페이~~~~',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ))),
            const SizedBox(width: 4.0),
            Expanded(
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue[600],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text(
                      '각자 결제~~~~',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ))),
            const SizedBox(width: 4.0),
          ],
        ),
      ],
    );
  }
}
