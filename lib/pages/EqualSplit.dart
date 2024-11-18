
import 'package:flutter/material.dart';
import 'package:lunch_calculator/common/layout.dart';

class EqualSplitTab extends StatefulWidget {
  const EqualSplitTab({super.key});

  @override
  State<EqualSplitTab> createState() => _EqualSplitTabState();
}

class _EqualSplitTabState extends State<EqualSplitTab> {
  final TextEditingController totalController = TextEditingController();
  final TextEditingController peopleController = TextEditingController();
  final TextEditingController percentDiscountController = TextEditingController();
  final TextEditingController fixedDiscountController = TextEditingController();
  final TextEditingController deliveryFeeController = TextEditingController();
  double? result;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    totalController.dispose();
    peopleController.dispose();
    deliveryFeeController.dispose();
    percentDiscountController.dispose();
    fixedDiscountController.dispose();
    super.dispose();
  }

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
    return Layout(
      title: 'N분의 1 정산',
      custom: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
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
        )
      ],
    );
  }
}