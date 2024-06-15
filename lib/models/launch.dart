import 'package:json_annotation/json_annotation.dart';
import 'package:spacex/models/launchpad.dart';
import 'package:spacex/models/rocket.dart';

@JsonSerializable()
class Launch {
  final Links links;
  final bool? success; // null in the upcoming launches
  final String name;
  final DateTime dateLocal;
  final String? details; // null in the upcoming launches
  final String rocketId;
  final String launchpadId;

  Rocket? rocket;
  Launchpad? launchpad;
  String defaultRocketImage = 'assests/image/rocketPlaceHolder.jpeg';

  Launch({
    required this.links,
    required this.success,
    required this.name,
    required this.dateLocal,
    required this.details,
    required this.rocketId,
    required this.launchpadId,
    this.rocket,
    this.launchpad,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      links: Links.fromJson(json['links']),
      success: json['success'],
      name: json['name'],
      dateLocal: DateTime.parse(json['date_local']),
      details: json['details'],
      rocketId: json['rocket'],
      launchpadId: json['launchpad'],
    );
  }
}

class Links {
  final Patch? patch;
  final String? wikipedia;

  Links({
    required this.patch,
    required this.wikipedia,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      patch: Patch.fromJson(json['patch']),
      wikipedia: json['wikipedia'],
    );
  }
}

class Patch {
  final String? smallImagURL;

  Patch({
    required this.smallImagURL,
  });

  factory Patch.fromJson(Map<String, dynamic> json) {
    return Patch(
      smallImagURL: json['small'],
    );
  }
}
