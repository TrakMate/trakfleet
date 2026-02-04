// class BaseURLConfig {
//   static const String baseURL = 'https://ev-backend.trakmatesolutions.com';

//   // login
//   static const String loginApiURL = '$baseURL/api/signin';

//   // user CRUD
//   static const String userApiURL = '$baseURL/api/user';

//   // group CRUD
//   static const String groupApiURL = '$baseURL/api/groups';

//   // Commands CRUD
//   static const String commandsALLApiURL = '$baseURL/api/commands/ALL';

//   //api key CRUD
//   static const String apiKeyApiUrl = '$baseURL/api/apikey';

//   // devices/vehicles CRUD
//   static const String devicesApiUrl = '$baseURL/api/device?';

//   // trips
//   static const String tripsApiUrl = '$baseURL/api/trips';

//   // dasboard all data
//   static const String dashboardApiUrl = '$baseURL/api/dashboard/evAllData';

//   // alerts
//   static const String alertsApiUrl = '$baseURL/api/dashboard/evAllDatalistData';

//   // trip data
//   static const String tripApiUrl =
//       '$baseURL/api/trips?currentIndex=0&sizePerPage=10';

//   static const String vehicleStatusApiUrl = '$baseURL/api/device';

//   static const String vehicleCommand = '$baseURL/api/commands';

//   static const String devicesStatusUrl = '$baseURL/api/device/dashboardMap';
// }

class BaseURLConfig {
<<<<<<< HEAD
  //   static const String baseURL = 'http://localhost:8001';
=======
  //   static const String baseURL = 'http://192.168.1.68:8001';
>>>>>>> c2ef342d8996b5efd33c2a858d85f2fad345860e
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

<<<<<<< HEAD
  // dashboard all details
  static const String dashboardApiUrl = '$baseURL/api/dashboard/details';
=======
  static const String devicesMapApiUrl = '$baseURL/api/v3/devices/map';

  // dashboard all details
  static const String dashboardApiUrl = '$baseURL/api/dashboard/summary';
>>>>>>> c2ef342d8996b5efd33c2a858d85f2fad345860e

  static const String alertDashboardApiUrl = '$baseURL/api/dashboard/alerts';

  static const String tripDashboardApiUrl = '$baseURL/api/dashboard/trips';

  static const String vehicleDashboardApiUrl =
      '$baseURL/api/dashboard/vehicles';

  //device full details
<<<<<<< HEAD
  static const String deviceDetailsApiUrl = '$baseURL/api/v3/devices';
=======
  static const String deviceDetailsApiUrl = '$baseURL/api/v3/devices?';
>>>>>>> c2ef342d8996b5efd33c2a858d85f2fad345860e
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
