class IMEIDistSpeedSocModel {
  String? imei;
  List<DistanceSpeedSocEntities>? entities;

  IMEIDistSpeedSocModel({this.imei, this.entities});

  IMEIDistSpeedSocModel.fromJson(Map<String, dynamic> json) {
    imei = json['imei'];
    if (json['entities'] != null) {
      entities = <DistanceSpeedSocEntities>[];
      json['entities'].forEach((v) {
        entities!.add(new DistanceSpeedSocEntities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imei'] = this.imei;
    if (this.entities != null) {
      data['entities'] = this.entities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DistanceSpeedSocEntities {
  final String? timeHr;
  final double? soc;
  final double? distance;
  final double? speed;

  DistanceSpeedSocEntities({this.timeHr, this.soc, this.distance, this.speed});

  factory DistanceSpeedSocEntities.fromJson(Map<String, dynamic> json) {
    return DistanceSpeedSocEntities(
      timeHr: json['time_hr'] as String?,
      soc: (json['soc'] as num?)?.toDouble(),
      distance: (json['Distance'] as num?)?.toDouble(),
      speed: (json['speed'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_hr'] = this.timeHr;
    data['soc'] = this.soc;
    data['Distance'] = this.distance;
    data['speed'] = this.speed;
    return data;
  }
}
