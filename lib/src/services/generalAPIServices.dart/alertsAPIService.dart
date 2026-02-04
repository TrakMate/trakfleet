import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/alertsModel.dart';
import '../apiURL.dart';

class AlertsApiService {
  static const String baseUrl = BaseURLConfig.alertsApiUrl;

  Future<AlertsModel> fetchAlerts({
    required int currentIndex,
    required int sizePerPage,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    final uri = Uri.parse(
      "$baseUrl?currentIndex=$currentIndex&sizePerPage=$sizePerPage",
    );

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return AlertsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load alerts");
    }
  }
}
