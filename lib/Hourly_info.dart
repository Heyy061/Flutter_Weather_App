import 'dart:ui';
import "package:flutter/material.dart";

class HourlyInfo extends StatelessWidget {
  final String time;
  final IconData icon2;
  final String temp;
  const HourlyInfo({
    super.key,
    required this.time,
    required this.icon2,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          //custom widget for card size
          width: 130,

          //1st card boxx
          child: Card(
            elevation: 5,
            shadowColor: const Color.fromARGB(255, 252, 199, 6),

            color: Color.fromRGBO(235, 239, 239, 0.475),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 126, 125, 125),
                        offset: Offset(4, 4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 6),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6),
                      Icon(
                        icon2,
                        size: 25,
                        color: Color.fromRGBO(237, 240, 241, 1),
                      ),
                      SizedBox(height: 8),
                      Text(
                        temp,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight(480),
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
