// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  Color? color;
  final String text;
  double size = 25;
  PriceText({
    super.key,
    this.color = const Color(0xFF869013),
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontFamily: "Inter", fontWeight: FontWeight.bold),
    );
  }
}
