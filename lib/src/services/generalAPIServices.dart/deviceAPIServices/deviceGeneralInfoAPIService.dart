import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_fleet_management/src/models/imeiDistSpeedSocModel.dart';
import 'package:tm_fleet_management/src/models/imeiGraphModel.dart';
import 'package:tm_fleet_management/src/services/apiURL.dart';

import '../../../models/imeiAlertsDetailsModel.dart';
import '../../../models/imeiTripMappointsModel.dart';
import '../../../models/imeiTripsDetailsModel.dart';
import '../../../models/tripMAPModel.dart';

class IMEIAlertsApiService {
  static const String baseUrl = BaseURLConfig.deviceAlertsApiUrl;

  Future<IMEIAlertsDetailsModel> fetchAlerts({
    required String imei,
    required int currentIndex,
    required int sizePerPage,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    final uri = Uri.parse(
      "$baseUrl/$imei?currentIndex=$currentIndex&sizePerPage=$sizePerPage",
    );

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return IMEIAlertsDetailsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load alerts");
    }
  }
}

class IMEITripsApiService {
  static const String baseUrl = BaseURLConfig.deviceTripsApiUrl;

  Future<IMEITripDetailsModel> fetchTrips({
    required String imei,
    required int currentIndex,
    required int sizePerPage,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    final uri = Uri.parse(
      "$baseUrl/$imei?currentIndex=$currentIndex&sizePerPage=$sizePerPage",
    );

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return IMEITripDetailsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load imwi trips");
    }
  }
}

class IMEITripMapPointsApiService {
  static const String baseUrl = BaseURLConfig.deviceTripMapPointsApiUrl;

  Future<IMEITripMapPointsModel> fetchTripMapPoints({
    required String imei,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    final uri = Uri.parse("$baseUrl/$imei");

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return IMEITripMapPointsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load trip map points: ${response.body}");
    }
  }
}

class IMEITripMapApiService {
  static const String baseUrl = BaseURLConfig.deviceTripMapApiUrl;

  Future<TripMapPerTripModel> fetchTripMap({required String imei}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    final String currentDate =
        DateTime.now().toIso8601String().split('T').first;

    final uri = Uri.parse(
      "$baseUrl/$imei",
    ).replace(queryParameters: {'date': currentDate});

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return TripMapPerTripModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        "Failed to load trip map: ${response.statusCode} ${response.body}",
      );
    }
  }
}

class IMEIGraphApiService {
  static const String baseUrl = BaseURLConfig.deviceGraphApiUrl;

  Future<IMEIGraphModel> fetchVehicleGraph({
    required String imei,
    required DateTime date,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? '';

    final formattedDate = DateFormat('yyyy-MM-dd').format(date);

    final uri = Uri.parse(
      '$baseUrl/$imei',
    ).replace(queryParameters: {'date': formattedDate});

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return IMEIGraphModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load vehicle graph (${response.statusCode})');
    }
  }
}

class IMEISpeedDistanceApiService {
  static const String baseUrl = BaseURLConfig.deviceDistSpeedSocApiUrl;

  Future<IMEIDistSpeedSocModel> fetchSpeedDistanceSoc({
    required String imei,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? '';

    final uri = Uri.parse('$baseUrl/$imei');

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return IMEIDistSpeedSocModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception(
        'Failed to load speed-distance-SOC data (${response.statusCode})',
      );
    }
  }
}
