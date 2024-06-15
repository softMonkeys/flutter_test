import 'package:flutter/material.dart';
import 'package:spacex/widgets/swtich_panel.dart';

enum Filter {
  pastLaunches,
  futureLaunches,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  });

  final Map<Filter, bool> currentFilters;

  @override
  State<StatefulWidget> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FiltersScreen> {
  var _pastLaunchesOn = true;
  var _futureLaunchesOn = true;

  @override
  void initState() {
    super.initState();
    _pastLaunchesOn = widget.currentFilters[Filter.pastLaunches] ?? true;
    _futureLaunchesOn = widget.currentFilters[Filter.futureLaunches] ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Your Launches ...'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) return;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pop<Map<Filter, bool>>({
              Filter.pastLaunches: _pastLaunchesOn,
              Filter.futureLaunches: _futureLaunchesOn,
            });
          });
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                'Past / Future',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SwitchPanel(
              isSwitchOn: _pastLaunchesOn,
              switchCallback: (bool isSwitchOn) {
                setState(() {
                  _pastLaunchesOn = isSwitchOn;
                });
              },
              title: 'Past Launches',
              subTitle: 'Include future launches',
            ),
            SwitchPanel(
              isSwitchOn: _futureLaunchesOn,
              switchCallback: (bool isSwitchOn) {
                setState(() {
                  _futureLaunchesOn = isSwitchOn;
                });
              },
              title: 'Future Launches',
              subTitle: 'Include future launches',
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                'Launch Years',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SwitchPanel(
              isSwitchOn: _futureLaunchesOn,
              switchCallback: (bool isSwitchOn) {
                setState(() {
                  _futureLaunchesOn = isSwitchOn;
                });
              },
              title: '2022',
            ),
            SwitchPanel(
              isSwitchOn: _futureLaunchesOn,
              switchCallback: (bool isSwitchOn) {
                setState(() {
                  _futureLaunchesOn = isSwitchOn;
                });
              },
              title: '2021',
            ),
            SwitchPanel(
              isSwitchOn: _futureLaunchesOn,
              switchCallback: (bool isSwitchOn) {
                setState(() {
                  _futureLaunchesOn = isSwitchOn;
                });
              },
              title: '2020',
            ),
            SwitchPanel(
              isSwitchOn: _futureLaunchesOn,
              switchCallback: (bool isSwitchOn) {
                setState(() {
                  _futureLaunchesOn = isSwitchOn;
                });
              },
              title: '2019',
            ),
          ],
        ),
      ),
    );
  }
}
