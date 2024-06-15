import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:spacex/models/drawer_types.dart';
import 'package:spacex/models/launch.dart';
import 'package:spacex/screens/categories.dart';
import 'package:spacex/screens/filters.dart';
import 'package:spacex/screens/saved_launches.dart';
import 'package:spacex/widgets/drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  final logger = Logger();

  int _selectedPageIndex = 0;
  final List<Launch> _favovoriteLaunches = [];
  Map<Filter, bool> _selectedFilters = {
    Filter.pastLaunches: true,
    Filter.futureLaunches: true,
  };

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleLaunchFavoriteStatus(Launch launch) {
    final isExisting = _favovoriteLaunches.contains(launch);

    if (isExisting) {
      setState(() {
        _favovoriteLaunches.remove(launch);
      });
      _showInfoMessage('Launch deleted');
    } else {
      setState(() {
        _favovoriteLaunches.add(launch);
      });
      _showInfoMessage('Launch added');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(DrawerType identifier) async {
    Navigator.of(context).pop();

    switch (identifier) {
      case DrawerType.launches:
        {
          // Do nothing
        }

      case DrawerType.filters:
        {
          final result = await Navigator.of(context).push<Map<Filter, bool>>(
            MaterialPageRoute(
              builder: (ctx) => FiltersScreen(
                currentFilters: _selectedFilters,
              ),
            ),
          );

          setState(() {
            if (result != null) _selectedFilters = result;
          });
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      selectedFilters: _selectedFilters,
      onToggleFavorite: _toggleLaunchFavoriteStatus,
    );

    var activePageTitle = 'SPACEX';

    if (_selectedPageIndex == 1) {
      activePage = SavedLaunchesScreen(
        favoriteLaunches: _favovoriteLaunches,
        onToggleFavorite: _toggleLaunchFavoriteStatus,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 6,
        onTap: (index) {
          _selectPage(index);
        },
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}
