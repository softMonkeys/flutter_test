import 'package:flutter/material.dart';
import 'package:spacex/screens/filters.dart';

enum LaunchType {
  upcoming,
  past,
}

class LaunchCategory {
  const LaunchCategory({
    required this.launchType,
    required this.title,
    this.color = Colors.black,
    required this.image,
    required this.filter,
  });

  final LaunchType launchType;
  final String title;
  final Color color;
  final String image;
  final Filter filter;
}
