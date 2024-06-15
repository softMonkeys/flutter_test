import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:spacex/models/launch.dart';
import 'package:spacex/models/launchpad.dart';
import 'package:spacex/models/rocket.dart';
import 'package:logger/logger.dart';

class LaunchesProvider with ChangeNotifier {
  final logger = Logger();

  late List<Launch> _upcomingLaunches;
  late List<Launch> _pastLaunches;
  late List<Rocket> _rockets;
  late List<Launchpad> _launchpads;

  List<Launch> get upcomingLaunches => _upcomingLaunches;
  List<Launch> get pastLaunches => _pastLaunches;
  List<Rocket> get rockets => _rockets;
  List<Launchpad> get launchpads => _launchpads;

  LaunchesProvider() {
    _upcomingLaunches = [];
    _pastLaunches = [];
    _rockets = [];
    _launchpads = [];
    fetchUpcomingLaunches();
    fetchPastLaunches();
    fetchRockets();
    fetchLaunchpads();
  }

  Future<void> fetchUpcomingLaunches() async {
    try {
      final response =
          await Dio().get('https://api.spacexdata.com/v5/launches/upcoming');
      if (response.statusCode == 200) {
        List<Launch> unsortedList = List<Launch>.from(
            response.data.map((launch) => Launch.fromJson(launch)));

        unsortedList.sort((a, b) => a.dateLocal.compareTo(b.dateLocal));
        _upcomingLaunches = unsortedList;
        notifyListeners();
      }
    } catch (error) {
      logger.d('Error fetching upcoming launches: $error');
    }
  }

  Future<void> fetchPastLaunches() async {
    try {
      final response =
          await Dio().get('https://api.spacexdata.com/v5/launches/past');
      if (response.statusCode == 200) {
        List<Launch> unsortedList = List<Launch>.from(
            response.data.map((launch) => Launch.fromJson(launch)));

        unsortedList.sort((a, b) => a.dateLocal.compareTo(b.dateLocal));
        _pastLaunches = unsortedList;
        notifyListeners();
      }
    } catch (error) {
      logger.d('Error fetching past launches: $error');
    }
  }

  Future<void> fetchRockets() async {
    try {
      final response = await Dio().get('https://api.spacexdata.com/v4/rockets');
      if (response.statusCode == 200) {
        _rockets = List<Rocket>.from(
            response.data.map((rocket) => Rocket.fromJson(rocket)));
        notifyListeners();
      }
    } catch (error) {
      logger.d('Error fetching rockets: $error');
    }
  }

  Future<void> fetchLaunchpads() async {
    try {
      final response =
          await Dio().get('https://api.spacexdata.com/v4/launchpads');
      if (response.statusCode == 200) {
        _launchpads = List<Launchpad>.from(
            response.data.map((launchpad) => Launchpad.fromJson(launchpad)));
        notifyListeners();
      }
    } catch (error) {
      logger.d('Error fetching launchpads: $error');
    }
  }

  Rocket? findRocketById(String id) {
    try {
      return _rockets.firstWhere((rocket) => rocket.id == id);
    } catch (e) {
      logger.d('Rocket with id $id not found.');
      return null;
    }
  }

  Launchpad? findLaunchPadById(String id) {
    try {
      return _launchpads.firstWhere((launchPad) => launchPad.id == id);
    } catch (e) {
      logger.d('Launchpad with id $id not found.');
      return null;
    }
  }
}
