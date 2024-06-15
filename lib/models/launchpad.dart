import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Launchpad {
  final String fullName;
  final String id;

  const Launchpad({
    required this.fullName,
    required this.id,
  });

  factory Launchpad.fromJson(Map<String, dynamic> json) {
    return Launchpad(
      fullName: json['full_name'],
      id: json['id'],
    );
  }
}
