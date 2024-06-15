import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Rocket {
  final String id;
  final List<PayloadWeight> payloadWeights;
  final String name;

  const Rocket(
      {required this.id, required this.payloadWeights, required this.name});

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      id: json['id'],
      name: json['name'],
      payloadWeights: (json['payload_weights'] as List<dynamic>?)
              ?.map((weight) => PayloadWeight.fromJson(weight))
              .toList() ??
          [],
    );
  }
}

class PayloadWeight {
  final String name;

  PayloadWeight({
    required this.name,
  });

  factory PayloadWeight.fromJson(Map<String, dynamic> json) {
    return PayloadWeight(
      name: json['name'],
    );
  }
}
