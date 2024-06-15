import 'package:flutter/material.dart';
import 'package:spacex/models/launch.dart';
import 'package:spacex/widgets/launch_item.dart';

class SavedLaunchesScreen extends StatelessWidget {
  const SavedLaunchesScreen({
    super.key,
    required this.favoriteLaunches,
    required this.onToggleFavorite,
  });

  final List<Launch> favoriteLaunches;
  final void Function(Launch launch) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    bool hasFavorites = favoriteLaunches.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: hasFavorites ? favoriteList(context) : emptyView(context),
    );
  }

  ListView favoriteList(BuildContext context) {
    return ListView.builder(
      itemCount: favoriteLaunches.length,
      itemBuilder: (context, index) {
        Launch launch = favoriteLaunches[index];

        if (launch.name.isEmpty) {
          return emptyView(context);
        }

        return LaunchItem(
          launch: launch,
          onToggleFavorite: onToggleFavorite,
        );
      },
    );
  }

  Center emptyView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Nothing here ...',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 1,
          ),
          Text(
            'Try selecting a different launch',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.background),
          ),
        ],
      ),
    );
  }
}
