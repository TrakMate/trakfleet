class DevicesMapModel {
  List<Entities>? entities;

  DevicesMapModel({this.entities});

  DevicesMapModel.fromJson(Map<String, dynamic> json) {
    if (json['entities'] != null) {
      entities = <Entities>[];
      json['entities'].forEach((v) {
        entities!.add(new Entities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.entities != null) {
      data['entities'] = this.entities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Entities {
  String? imei;
  double? lat;
  double? lng;
  String? status;
  String? soh;
  String? soc;
  String? vehicleNumber; // Add if needed
  String? odometer; // Add if needed
  int? totalTrips; // Add if needed
  int? totalAlerts; // Add if needed
  String? location; // Add if needed
  String? locationLogDate; // Add if needed

  Entities({this.imei, this.lat, this.lng, this.status, this.soh, this.soc});

  Entities.fromJson(Map<String, dynamic> json) {
    imei = json['imei'];
    lat = json['lat'];
    lng = json['lng'];
    status = json['status'];
    soh = json['soh'];
    soc = json['soc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imei'] = this.imei;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['status'] = this.status;
    data['soh'] = this.soh;
    data['soc'] = this.soc;
    return data;
  }
}
