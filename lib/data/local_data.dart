import 'package:flutter/material.dart';
import 'package:spacex/Models/launches_category.dart';
import 'package:spacex/screens/filters.dart';

const availableLaunchCategories = [
  LaunchCategory(
    launchType: LaunchType.past,
    title: 'Past Launches',
    color: Colors.purple,
    image: 'assests/image/pastLaunch.jpeg',
    filter: Filter.pastLaunches,
  ),
  LaunchCategory(
    launchType: LaunchType.upcoming,
    title: 'Future Launches',
    color: Colors.red,
    image: 'assests/image/futureLaunch.jpeg',
    filter: Filter.futureLaunches,
  ),
];
