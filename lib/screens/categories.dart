import 'package:flutter/material.dart';
import 'package:spacex/data/local_data.dart';
import 'package:spacex/models/launch.dart';
import 'package:spacex/screens/filters.dart';
import 'package:spacex/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite,
    required this.selectedFilters,
  });

  final void Function(Launch launch) onToggleFavorite;
  final Map<Filter, bool> selectedFilters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Please select your launch'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.5,
          mainAxisSpacing: 30,
        ),
        children: <CategoryGridItem>[
          for (final launchCategory in availableLaunchCategories)
            if (selectedFilters[launchCategory.filter] != null &&
                selectedFilters[launchCategory.filter] == true)
              CategoryGridItem(
                launchCategory: launchCategory,
                onToggleFavorite: onToggleFavorite,
              )
        ],
      ),
    );
  }
}
