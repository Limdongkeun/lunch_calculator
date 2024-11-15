import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunch_calculator/common/layout.dart';

class DutchPay extends StatefulWidget {
  const DutchPay({super.key});

  @override
  State<DutchPay> createState() => _DutchPayState();
}

class _DutchPayState extends State<DutchPay> {

  final TextEditingController _totalAmount = TextEditingController();
  final ValueNotifier<bool> _totalAmountCheck = ValueNotifier(true);


  final TextEditingController _discountAmount = TextEditingController();
  final ValueNotifier<bool> _discountAmountCheck = ValueNotifier(true);


  final TextEditingController _deliveryAmount = TextEditingController();
  final ValueNotifier<bool> _deliveryAmountCheck = ValueNotifier(true);


  final TextEditingController _memberCount = TextEditingController();
  final ValueNotifier<bool> _memberCountCheck = ValueNotifier(true);


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: '한 번에 간편하게!!',
      icon: const Icon(
        Icons.point_of_sale,
        size: 30.0,
        color: Colors.black,
      ),
      custom: [
        Column(
          children: [
            const Row(
              children: [
                SizedBox(width: 4.0),
                Text('총 금액',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 4.0),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _totalAmount,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: '오늘은 총 얼마~~~?',
                      labelText: '총 금액',
                      contentPadding: kIsWeb ? const EdgeInsets.fromLTRB(12, 16, 12, 16) : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          width: 2.0,
                          color: _totalAmountCheck.value ? Colors.blue : Colors.red
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          width: 2.0,
                          color: _totalAmountCheck.value ? Colors.blue : Colors.red
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            const Row(
              children: [
                SizedBox(width: 4.0),
                Text('할인 금액',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 4.0),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _discountAmount,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: '오늘은 아낀 돈은~~~?',
                      labelText: '총 할인',
                      contentPadding: kIsWeb ? const EdgeInsets.fromLTRB(12, 16, 12, 16) : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                            width: 2.0,
                            color: _discountAmountCheck.value ? Colors.blue : Colors.red
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                            width: 2.0,
                            color: _discountAmountCheck.value ? Colors.blue : Colors.red
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            const Row(
              children: [
                SizedBox(width: 4.0),
                Text('배달 금액',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 4.0),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _deliveryAmount,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: '배달비 진짜 너무 아까워,,,,',
                      labelText: '징말 제발 공짜ㅠㅠ',
                      contentPadding: kIsWeb ? const EdgeInsets.fromLTRB(12, 16, 12, 16) : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                            width: 2.0,
                            color: _deliveryAmountCheck.value ? Colors.blue : Colors.red
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                            width: 2.0,
                            color: _deliveryAmountCheck.value ? Colors.blue : Colors.red
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            const Row(
              children: [
                SizedBox(width: 4.0),
                Text('몇 명이나 묵었나?',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 4.0),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _memberCount,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: '나한테 돈 줄 사람~~~~~',
                      labelText: '돈 줘!',
                      contentPadding: kIsWeb ? const EdgeInsets.fromLTRB(12, 16, 12, 16) : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                            width: 2.0,
                            color: _memberCountCheck.value ? Colors.blue : Colors.red
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                            width: 2.0,
                            color: _memberCountCheck.value ? Colors.blue : Colors.red
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
