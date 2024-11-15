
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  final String title;
  final Icon icon;
  final List<Widget>? custom;

  const Layout({
   super.key,
   required this.title,
   required this.icon,
   this.custom,
  });

  @override
  State<StatefulWidget> createState() => _LayoutState();
}


class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              widget.icon,
            ],
          ),
          backgroundColor: Colors.blue[600],
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  const SizedBox(height: 24.0),
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        children: [
                          ...widget.custom!,
                        ],
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
