import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunch_calculator/common/layout.dart';

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

class _MyHomeAppState extends State<MyHomeApp> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController _totalAmount = TextEditingController();
  final ValueNotifier<bool> _totalAmountCheck = ValueNotifier(true);

  final TextEditingController _discountAmount = TextEditingController();
  final ValueNotifier<bool> _discountAmountCheck = ValueNotifier(true);

  final TextEditingController _deliveryAmount = TextEditingController();
  final ValueNotifier<bool> _deliveryAmountCheck = ValueNotifier(true);

  final TextEditingController _memberCount = TextEditingController();
  final ValueNotifier<bool> _memberCountCheck = ValueNotifier(true);

  final TextEditingController _paymentAmount = TextEditingController();

  final List<String> _names = [
    '헤이즐',
    '나리',
    '조엘',
    '주디',
    '조니',
    '한나',
    '올리버',
    '달시',
    '클로이',
    '큐리아',
    '케빈',
    '이안',
    '라이언',
    '윤',
    '소니',
    '토니',
    '앤',
    '블루',
    '바트',
    '조쉬',
    '헨리',
    '케이트',
    '루시아',
    '밤피',
    '아이다',
    '에드가',
    '엘라',
    '멀린',
    '케이',
  ];

  final ValueNotifier<Set<int>> _selectedIndices = ValueNotifier({});

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _totalAmount.dispose();
    _discountAmount.dispose();
    _deliveryAmount.dispose();
    _memberCount.dispose();
    _totalAmountCheck.dispose();
    _discountAmountCheck.dispose();
    _deliveryAmountCheck.dispose();
    _memberCountCheck.dispose();
    super.dispose();
  }

  Widget _dutchPay() {
    return Layout(
      title: '한 번에 간편하게!!',
      icon: const Icon(
        Icons.money_outlined,
        size: 30.0,
        color: Colors.white,
      ),
      custom: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 4.0),
                const Expanded(
                  flex: 2,
                  child: Text(
                    '총 금액',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _totalAmount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: '오늘은 총 얼마~~~?',
                      labelText: '총 금액',
                      contentPadding: kIsWeb ? const EdgeInsets.fromLTRB(12, 16, 12, 16) : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(width: 2.0, color: _totalAmountCheck.value ? Colors.blue : Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(width: 2.0, color: _totalAmountCheck.value ? Colors.blue : Colors.red),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 4.0),
                const Expanded(
                  flex: 2,
                  child: Text(
                    '할인 금액',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _discountAmount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: '오늘은 아낀 돈은~~~?',
                      labelText: '총 할인',
                      contentPadding: kIsWeb ? const EdgeInsets.fromLTRB(12, 16, 12, 16) : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(width: 2.0, color: _discountAmountCheck.value ? Colors.blue : Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(width: 2.0, color: _discountAmountCheck.value ? Colors.blue : Colors.red),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 4.0),
                const Expanded(
                  flex: 2,
                  child: Text(
                    '배달 금액',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _deliveryAmount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: '배달비 진짜 너무 아까워,,,,',
                      labelText: '징말 제발 공짜ㅠㅠ',
                      contentPadding: kIsWeb ? const EdgeInsets.fromLTRB(12, 16, 12, 16) : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(width: 2.0, color: _deliveryAmountCheck.value ? Colors.blue : Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(width: 2.0, color: _deliveryAmountCheck.value ? Colors.blue : Colors.red),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 4.0),
                const Expanded(
                  flex: 2,
                  child: Text(
                    '몇 명 묵었나?',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _memberCount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: '나한테 돈 줄 사람~~~~~',
                      labelText: '돈 줘!',
                      contentPadding: kIsWeb ? const EdgeInsets.fromLTRB(12, 16, 12, 16) : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(width: 2.0, color: _memberCountCheck.value ? Colors.blue : Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(width: 2.0, color: _memberCountCheck.value ? Colors.blue : Colors.red),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
              ],
            ),
          ],
        ),
        const Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 4.0),
            const Expanded(
              flex: 2,
              child: Text(
                '그래서 얼마?',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: _paymentAmount,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: '나한테 돈 줄 얼마~~~~~',
                  contentPadding: kIsWeb ? const EdgeInsets.fromLTRB(12, 16, 12, 16) : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(width: 2.0, color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(width: 2.0, color: Colors.blue),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
          ],
        ),
        const SizedBox(height: 64.0),
      ],
    );
  }

  Widget _singlePay() {
    return Layout(
      title: '나한테 줄 돈은??',
      icon: const Icon(
        Icons.money_outlined,
        size: 30.0,
        color: Colors.white,
      ),
      custom: [
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 4.0),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        '총 금액',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _totalAmount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: '오늘은 총 얼마~~~?',
                          labelText: '총 금액',
                          contentPadding: kIsWeb ? const EdgeInsets.fromLTRB(12, 16, 12, 16) : null,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                BorderSide(width: 2.0, color: _totalAmountCheck.value ? Colors.blue : Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                BorderSide(width: 2.0, color: _totalAmountCheck.value ? Colors.blue : Colors.red),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 4.0),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        '할인 금액',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _discountAmount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: '오늘은 아낀 돈은~~~?',
                          labelText: '총 할인',
                          contentPadding: kIsWeb ? const EdgeInsets.fromLTRB(12, 16, 12, 16) : null,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                BorderSide(width: 2.0, color: _discountAmountCheck.value ? Colors.blue : Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                BorderSide(width: 2.0, color: _discountAmountCheck.value ? Colors.blue : Colors.red),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 4.0),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        '배달 금액',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _deliveryAmount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: '배달비 진짜 너무 아까워,,,,',
                          labelText: '징말 제발 공짜ㅠㅠ',
                          contentPadding: kIsWeb ? const EdgeInsets.fromLTRB(12, 16, 12, 16) : null,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                BorderSide(width: 2.0, color: _deliveryAmountCheck.value ? Colors.blue : Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                BorderSide(width: 2.0, color: _deliveryAmountCheck.value ? Colors.blue : Colors.red),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                  ],
                ),
                const SizedBox(height: 12.0),
                ValueListenableBuilder<Set<int>>(
                  valueListenable: _selectedIndices,
                  builder: (context, selectedIndices, child) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      itemCount: _names.length,
                      // Number of names in the list
                      itemBuilder: (context, index) {
                        final isSelected = selectedIndices.contains(index);
                        return GestureDetector(
                          onTap: () {

                            if (isSelected) {
                              _selectedIndices.value = selectedIndices..remove(index);
                            } else {
                              _selectedIndices.value = selectedIndices..add(index);
                            }
                            _selectedIndices.notifyListeners();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blue : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: isSelected ? Colors.blueAccent : Colors.grey,
                                width: 2.0,
                              ),
                            ),
                            child: Text(
                              _names[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 64.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 4.0),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        '그래서 얼마?',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _paymentAmount,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: '나한테 돈 줄 얼마~~~~~',
                          contentPadding: kIsWeb ? const EdgeInsets.fromLTRB(12, 16, 12, 16) : null,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(width: 2.0, color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: '오늘 점심 얼마??',
      icon: const Icon(
        Icons.fastfood,
        size: 30.0,
        color: Colors.white,
      ),
      custom: [
        Row(
          children: [
            const SizedBox(width: 4.0),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _tabController.animateTo(0);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _tabController.index == 0 ? Colors.blue[600] : Colors.grey,
                    border: Border.all(width: 2.0, color: _tabController.index == 0 ? Colors.blue : Colors.grey),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const Text(
                    '더치 페이~~~~~~',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _tabController.animateTo(1);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _tabController.index == 1 ? Colors.blue[600] : Colors.grey,
                    border: Border.all(width: 2.0, color: _tabController.index == 1 ? Colors.blue : Colors.grey),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    '각자 결제~~~~~~',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4.0),
          ],
        ),
        const SizedBox(height: 24.0),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              _dutchPay(),
              _singlePay(),
            ],
          ),
        ),
      ],
    );
  }
}
