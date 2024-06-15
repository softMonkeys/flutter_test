import 'package:flutter/material.dart';
import 'package:spacex/Models/launches_category.dart';
import 'package:spacex/models/launch.dart';
import 'package:spacex/screens/past_launches.dart';
import 'package:spacex/screens/upcoming_launches.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.launchCategory,
    required this.onToggleFavorite,
  });

  final LaunchCategory launchCategory;
  final void Function(Launch launch) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        switch (launchCategory.launchType) {
          LaunchType.upcoming => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => UpcomingLaunchesScreen(
                      onToggleFavorite: onToggleFavorite),
                ),
              )
            },
          LaunchType.past => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) =>
                      PastLaunchesScreen(onToggleFavorite: onToggleFavorite),
                ),
              )
            },
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(
              launchCategory.image,
            ),
            fit: BoxFit.fill,
          ),
          gradient: LinearGradient(
            colors: [
              launchCategory.color.withOpacity(0.5),
              launchCategory.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          launchCategory.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 35,
              ),
        ),
      ),
    );
  }
}
