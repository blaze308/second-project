// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  final Color? color;
  final String text;
  TextOverflow textOverflow;
  LargeText({
    super.key,
    this.textOverflow = TextOverflow.ellipsis,
    this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      style: const TextStyle(
          fontFamily: "Inter",
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold),
    );
  }
}
