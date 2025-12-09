import 'package:flutter/material.dart';

//Widget titulo con línea
class SectionTitle extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color lineColor;

  const SectionTitle({
    super.key,
    required this.text,
    required this.textColor,
    required this.lineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 2,
          width: double.infinity,
          color: lineColor,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
