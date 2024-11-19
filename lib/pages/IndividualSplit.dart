
import 'package:flutter/material.dart';
import 'package:lunch_calculator/common/layout.dart';

class IndividualSplitTab extends StatefulWidget {
  const IndividualSplitTab({super.key});

  @override
  State<IndividualSplitTab> createState() => _IndividualSplitTabState();
}

class _IndividualSplitTabState extends State<IndividualSplitTab> {
  List<Member> members = [];
  final TextEditingController couponController = TextEditingController();
  final TextEditingController deliveryFeeController = TextEditingController();
  final TextEditingController percentDiscountController = TextEditingController();
  final TextEditingController fixedDiscountController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    couponController.dispose();
    deliveryFeeController.dispose();
    percentDiscountController.dispose();
    fixedDiscountController.dispose();
    super.dispose();
  }

  void addMember() {
    setState(() {
      members.add(Member(name: '', amount: 0));
    });
  }

  void calculateIndividualSplit() {

    for(var member in members) {
      if(member.name.isEmpty || member.amount == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('모든 멤버의 이름과 금액을 입력해주세요.'),
            duration: Duration(seconds: 1),
          ),
        );
        return;
      }
    }

    final totalAmount = members.fold<double>(
      0, (sum, member) => sum + member.amount,
    );

    final couponAmount = double.tryParse(couponController.text) ?? 0;
    final deliveryFee = double.tryParse(deliveryFeeController.text) ?? 0;
    final percentDiscount = double.tryParse(percentDiscountController.text) ?? 0;
    final fixedDiscount = double.tryParse(fixedDiscountController.text) ?? 0;

    final totalPercentDiscount = (totalAmount * percentDiscount / 100);
    final totalDiscount = totalPercentDiscount + fixedDiscount;


    setState(() {
      for (var member in members) {
        final ratio = member.amount / totalAmount;
        member.finalAmount = member.amount - (couponAmount * ratio) + (deliveryFee * ratio);

        member.finalAmount = member.amount
            - (couponAmount * ratio)
            + (deliveryFee * ratio)
            - (totalDiscount * ratio);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: '개별 정산',
      custom: [
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
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
                    margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: const BorderSide(width: 2.0, color: Colors.blueGrey),
                    ),
                    elevation: 4.0,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    members.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 24.0,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
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
                              ),
                              const SizedBox(width: 24.0),
                              Expanded(
                                child: TextField(
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
                              ),
                            ],
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
                }),
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
        )
      ],
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
