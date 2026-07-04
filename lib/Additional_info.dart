import "package:flutter/material.dart";

class Additionalinfo extends StatelessWidget {
  final IconData icon1;
  final String label;
  final String value;
  const Additionalinfo({
    super.key,
    required this.icon1,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon1, size: 38),
        SizedBox(height: 10),
        Text(label, style: TextStyle(fontSize: 22)),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
