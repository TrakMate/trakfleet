class BaseURLConfig {
  //   static const String baseURL = 'http://192.168.1.68:8001';
  static const String baseURL =
      'http://hero-trakmate.ap-south-1.elasticbeanstalk.com';

  // login
  static const String loginApiURL = '$baseURL/api/signin';

  //CRUD API URLs
  static const String userApiURL = '$baseURL/api/user';

  static const String groupApiURL = '$baseURL/api/groups';

  static const String commandsALLApiURL = '$baseURL/api/commands/ALL';

  static const String apiKeyApiUrl = '$baseURL/api/apikey';

  static const String devicesApiUrl = '$baseURL/api/device?';

  static const String devicesMapApiUrl = '$baseURL/api/v3/devices/map';

  // dashboard all details
  static const String dashboardApiUrl = '$baseURL/api/dashboard/summary';

  static const String alertDashboardApiUrl = '$baseURL/api/dashboard/alerts';

  static const String tripDashboardApiUrl = '$baseURL/api/dashboard/trips';

  static const String vehicleDashboardApiUrl =
      '$baseURL/api/dashboard/vehicles';

  //device full details
  static const String deviceDetailsApiUrl = '$baseURL/api/v3/devices?';
  static const String deviceConfigurationApiUrl = '$baseURL/api/commands';
  static const String deviceAlertsApiUrl = '$baseURL/api/alerts';
  static const String deviceTripsApiUrl = '$baseURL/api/tripfulldetails';
  static const String deviceTripMapPointsApiUrl = '$baseURL/api/tripmappoints';
  static const String deviceTripMapApiUrl = '$baseURL/api/device/map';
  static const String deviceGraphApiUrl = '$baseURL/api/device/graphDetails';
  static const String deviceDistSpeedSocApiUrl =
      '$baseURL/api/device/SpeedDistanceMap';

  // trips
  static const String tripsApiUrl = '$baseURL/api/trips/status';
  static const String tripsRoutePlayBackPerTripIDApiUrl =
      '$baseURL/api/trips/tripRoutePlayback/{tripId}';

  // alerts
  static const String alertsApiUrl = '$baseURL/api/alerts/all';
}
