import "package:flutter/material.dart";

class NextAdditional_info extends StatelessWidget {
  final IconData icon3;
  final String index;
  final String value;
  const NextAdditional_info({
    super.key,
    required this.icon3,
    required this.index,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon3, size: 38),
            SizedBox(height: 10),
            Text(
              index,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}
