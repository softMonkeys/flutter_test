import 'package:flutter/material.dart';
import 'package:spacex/models/launch.dart';
import 'package:spacex/providers/launches_provider.dart';
import 'package:provider/provider.dart';
import 'package:spacex/widgets/launch_item.dart';

class UpcomingLaunchesScreen extends StatelessWidget {
  const UpcomingLaunchesScreen({
    super.key,
    required this.onToggleFavorite,
  });

  final void Function(Launch launch) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final launchesProvider =
        Provider.of<LaunchesProvider>(context, listen: false);

    // Fetch upcoming launches data
    launchesProvider.fetchUpcomingLaunches();
    launchesProvider.fetchRockets();
    launchesProvider.fetchLaunchpads();

    return Scaffold(
      appBar: AppBar(
        title: const Text('UPCOMING'),
      ),
      body: Consumer<LaunchesProvider>(
        builder: (context, provider, _) {
          // Show loading indicator while data is being fetched
          if (provider.upcomingLaunches.isEmpty ||
              provider.rockets.isEmpty ||
              provider.launchpads.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Once data is fetched, display the actual UI
            return ListView.builder(
              itemCount: provider.upcomingLaunches.length,
              itemBuilder: (context, index) {
                Launch launch = provider.upcomingLaunches[index];

                if (launch.name.isEmpty) {
                  return emptyView(context);
                }

                launch.rocket = provider.findRocketById(launch.rocketId);
                launch.launchpad =
                    provider.findLaunchPadById(launch.launchpadId);

                return LaunchItem(
                  launch: launch,
                  onToggleFavorite: onToggleFavorite,
                );
              },
            );
          }
        },
      ),
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
            height: 16,
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
