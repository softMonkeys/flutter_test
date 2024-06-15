import 'package:flutter/material.dart';

class LaunchDetailText extends StatelessWidget {
  const LaunchDetailText({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: RichText(
          text: TextSpan(
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: description,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ]),
        ));
  }
}
