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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: Colors.grey[100],
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
  int _selectedIndex = 0;


  final List<Widget> _pages = [
    DutchPayScreen(), // 더치페이 화면
    IndividualPayScreen(), // 각자 결제 화면
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '정산 하기~??',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
        elevation: 5.0,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_rounded),
              label: '더치 페이',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: '각자 결제',
            ),
          ],
          selectedItemColor: Colors.teal[600],
          unselectedItemColor: Colors.grey[600],
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

// 더치페이 화면
class DutchPayScreen extends StatelessWidget {
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController peopleController = TextEditingController();
  final TextEditingController fixedController = TextEditingController();
  final TextEditingController percentController = TextEditingController();

  DutchPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "더치 페이",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: totalAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "총 금액 입력 (배달비 포함)",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: peopleController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "참여자 수",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: fixedController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "정액 할인 (선택)",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: percentController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "정률 할인 (%) (선택)",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final totalAmount = double.tryParse(totalAmountController.text);
                  final peopleCount = int.tryParse(peopleController.text);
                  final fixedDiscount = double.tryParse(fixedController.text) ?? 0.0;
                  final percentDiscount = double.tryParse(percentController.text) ?? 0.0;

                  if (totalAmount == null || peopleCount == null || peopleCount <= 0) {
                    _showMessage(context, "총 금액과 참여자 수는 필수 입력값입니다!");
                    return;
                  }

                  // 정액 할인 적용
                  double finalAmount = totalAmount - fixedDiscount;

                  // 정률 할인 적용
                  if (percentDiscount > 0) {
                    final percentOff = totalAmount * (percentDiscount / 100); // 할인 금액 계산
                    finalAmount -= percentOff;
                  }

                  // 결과 계산
                  if (finalAmount < 0) {
                    _showMessage(context, "할인 금액이 총 금액보다 클 수 없습니다!");
                    return;
                  }

                  final perPerson = finalAmount / peopleCount;
                  _showMessage(context, "1인당 ${perPerson.toStringAsFixed(2)}원입니다!");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[300],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("계산 하기"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }
}

// 각자 결제 화면
class IndividualPayScreen extends StatelessWidget {
  IndividualPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "각자 결제",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                "아직 안만들어서 기능 추가 필요",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showMessage(context, "아직 안만듬");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[300],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("계산 하기"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }
}
