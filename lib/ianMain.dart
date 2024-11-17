import 'package:flutter/material.dart';

class IanMain extends StatefulWidget {
  const IanMain({super.key});

  @override
  State<IanMain> createState() => _IanMainState();
}

class _IanMainState extends State<IanMain> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    EqualSplitTab(),
    IndividualSplitTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('점심값 정산'),
      ),
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

class EqualSplitTab extends StatefulWidget {
  @override
  State<EqualSplitTab> createState() => _EqualSplitTabState();
}

class _EqualSplitTabState extends State<EqualSplitTab> {
  final totalController = TextEditingController();
  final peopleController = TextEditingController();
  final percentDiscountController = TextEditingController();
  final fixedDiscountController = TextEditingController();
  final deliveryFeeController = TextEditingController();
  double? result;

  void calculateSplit() {
    final total = double.tryParse(totalController.text) ?? 0;
    final people = int.tryParse(peopleController.text) ?? 1;
    final percentDiscount = double.tryParse(percentDiscountController.text) ?? 0;
    final fixedDiscount = double.tryParse(fixedDiscountController.text) ?? 0;
    final deliveryFee = double.tryParse(deliveryFeeController.text) ?? 0;

    final discountedAmount = total * (percentDiscount / 100);
    final finalTotal = total - discountedAmount - fixedDiscount + deliveryFee;

    setState(() {
      result = finalTotal / people;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: totalController,
              decoration: const InputDecoration(
                labelText: '총 금액',
                prefixIcon: Icon(Icons.monetization_on),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: peopleController,
              decoration: const InputDecoration(
                labelText: '인원 수',
                prefixIcon: Icon(Icons.people),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: percentDiscountController,
              decoration: const InputDecoration(
                labelText: '할인율 (%)',
                prefixIcon: Icon(Icons.discount),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: fixedDiscountController,
              decoration: const InputDecoration(
                labelText: '정액 할인',
                prefixIcon: Icon(Icons.money_off),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: deliveryFeeController,
              decoration: const InputDecoration(
                labelText: '배달비',
                prefixIcon: Icon(Icons.delivery_dining),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: calculateSplit,
              icon: const Icon(Icons.calculate),
              label: const Text('정산하기'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            if (result != null) ...[
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text('1인당 정산 금액'),
                      const SizedBox(height: 8),
                      Text(
                        '${result!.toStringAsFixed(0)}원',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class IndividualSplitTab extends StatefulWidget {
  @override
  State<IndividualSplitTab> createState() => _IndividualSplitTabState();
}

class _IndividualSplitTabState extends State<IndividualSplitTab> {
  List<Member> members = [];
  final couponController = TextEditingController();
  final deliveryFeeController = TextEditingController();

  void addMember() {
    setState(() {
      members.add(Member(name: '', amount: 0));
    });
  }

  void calculateIndividualSplit() {
    final totalAmount = members.fold<double>(
      0,
          (sum, member) => sum + member.amount,
    );

    final couponAmount = double.tryParse(couponController.text) ?? 0;
    final deliveryFee = double.tryParse(deliveryFeeController.text) ?? 0;

    setState(() {
      for (var member in members) {
        final ratio = member.amount / totalAmount;
        member.finalAmount = member.amount - (couponAmount * ratio) + (deliveryFee * ratio);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: couponController,
              decoration: const InputDecoration(
                labelText: '쿠폰 금액',
                prefixIcon: Icon(Icons.confirmation_number),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: deliveryFeeController,
              decoration: const InputDecoration(
                labelText: '배달비',
                prefixIcon: Icon(Icons.delivery_dining),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: addMember,
              icon: const Icon(Icons.person_add),
              label: const Text('멤버 추가'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 24),
            ...members.asMap().entries.map((entry) {
              final index = entry.key;
              final member = entry.value;
              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            member.name = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: '멤버 ${index + 1} 이름',
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            member.amount = double.tryParse(value) ?? 0;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: '금액',
                          prefixIcon: Icon(Icons.monetization_on),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      if (member.finalAmount != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          '정산 금액: ${member.finalAmount!.toStringAsFixed(0)}원',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
            if (members.isNotEmpty) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: calculateIndividualSplit,
                icon: const Icon(Icons.calculate),
                label: const Text('정산하기'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class Member {
  String name;
  double amount;
  double? finalAmount;

  Member({
    required this.name,
    required this.amount,
    this.finalAmount,
  });
}

