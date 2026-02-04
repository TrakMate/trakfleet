import 'dart:ui';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../models/alertDashboardModel.dart';
// import '../../models/dashboardDetailsModel.dart';
import '../../models/groupsModel.dart';
import '../../models/tripsDashboardModel.dart';
import '../../models/vehicleDashboardModel.dart';
import '../../provider/fleetModeProvider.dart';
import '../../services/generalAPIServices.dart/dashboardAPIService.dart';
import '../../utils/appColors.dart';
import '../../utils/appResponsive.dart';
import '../components/largeHoverCard.dart';
import '../components/smallHoverCard.dart';
import '../widgets/charts/alertDoughnutChart.dart';
import '../widgets/charts/alertsChart.dart';
import '../widgets/charts/evBatteriesDistributionProgressBar.dart';
import '../widgets/charts/tripsChart.dart';
import '../widgets/charts/vehicleStatusProgressBar.dart';
import '../widgets/charts/vehicleUtilizationChart.dart';
import '../components/customTitleBar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  DateTime? selectedDate;

  String? selectedGroup;
  // String get dateParam => selectedDate.toUtc().toIso8601String();
  String? get dateParam =>
      selectedDate == null
          ? null
          : DateFormat('yyyy-MM-dd').format(selectedDate!);
  final DashboardApiService _dashboardApi = DashboardApiService();

  bool isLoadingGroups = false;

  String formatDateTime(String? value) {
    if (value == null || value.isEmpty) return '--';

    try {
      final dt = DateTime.parse(value).toLocal();
      return DateFormat('yyyy-MM-dd HH:mm a').format(dt);
    } catch (e) {
      return value; // fallback
    }
  }

  // Future<void> fetchDashboardDetails() async {
  //   setState(() => isDashboardLoading = true);

  //   try {
  //     final response = await _dashboardApi.fetchDashboardDetails(
  //       date: dateParam,
  //       groupId: selectedGroup,
  //     );

  //     setState(() {
  //       groupsList = response.groups ?? [];
  //       if (selectedGroup != null &&
  //           !groupsList.any((g) => g.id == selectedGroup)) {
  //         selectedGroup = null;
  //       }

  //       // VEHICLES
  //       totalVehicles = response.totalVehicles ?? 0;
  //       activeVehicles = response.activeVehicle ?? 0;
  //       inactiveVehicles = response.inactiveVehicle ?? 0;

  //       // STATUS
  //       moving = response.vehicleStatus!.moving ?? 0;
  //       idle = response.vehicleStatus!.idle ?? 0;
  //       stopped = response.vehicleStatus!.stopped ?? 0;
  //       disconnected = response.vehicleStatus!.disconnected ?? 0;
  //       nonCoverage = response.vehicleStatus!.noncoverage ?? 0;

  //       charging = response.vehicleStatus!.charging ?? 0;
  //       discharging = response.vehicleStatus!.disCharging ?? 0;
  //       batteryIdle = response.vehicleStatus?.idle ?? 0;
  //       batteryDisconnected = response.vehicleStatus?.disconnected ?? 0;

  //       // TRIPS
  //       tripsTotal = response.totalTrips ?? 0;
  //       completedTrips = response.completedTrips ?? 0;
  //       ongoingTrips = response.ongoingTrips ?? 0;
  //       totalDistance = response.totalDistance ?? 0;
  //       totalOperHours = response.totalOperateHr ?? 0;
  //       avgTripsDay = response.averageTrips ?? 0;
  //       totalConsumedEnergy = response.consumedFuel ?? 0;
  //       todayTotalDistance = response.todayDistanceKm ?? 0;
  //       todayTotalOperHr = response.todayOperHr ?? 0;
  //       yesterdayTotalDistanceKm = response.yesterdayDistanceKm ?? 0;
  //       yesterdayTotalOperHr = response.yesterdayOperHr ?? 0;

  //       // ALERTS
  //       totalAlerts = response.totalAlerts ?? 0;
  //       criticalAlerts = response.critical ?? 0;
  //       nonCriticalAlerts = response.nonCritical ?? 0;
  //       attentionNeededVehicles = response.faults ?? 0;

  //       recentAlerts =
  //           response.allAlerts?.map((e) => e.toJson()).toList() ?? [];

  //       //BMS Stats
  //       bmsStatsExcellent = response.bms!.excellent ?? 0;
  //       bmsStatsGood = response.bms!.good ?? 0;
  //       bmsStatsModerate = response.bms!.moderate ?? 0;
  //       bmsStatsPoor = response.bms!.poor ?? 0;

  //       // ALERT GRAPHS
  //       alertsWeeklyGraph = response.alertsGraph ?? [];
  //       alertsMonthlyGraph = response.alertGraphforMonth ?? [];

  //       tripsWeeklyGraph = response.tripsGraph ?? [];
  //       tripsMonthlyGraph = response.tripsGraphforMonth ?? [];

  //       vehicleUtilizationWeeklyGraph = response.vehicleutliGraph ?? [];
  //       vehicleUtilizationMonthlyGraph =
  //           response.vehicleutliGraphforMonth ?? [];
  //     });
  //   } catch (e) {
  //     debugPrint("Dashboard API error: $e");
  //   } finally {
  //     setState(() => isDashboardLoading = false);
  //   }
  // }

<<<<<<< HEAD
  Future<void> fetchAlertDetails() async {
    setState(() => isDashboardLoading = true);
=======
  Future<void> fetchAlertDetails({bool showLoading = true}) async {
    if (showLoading) setState(() => isDashboardLoading = true);
>>>>>>> c2ef342d8996b5efd33c2a858d85f2fad345860e

    try {
      final response = await _dashboardApi.fetchAlertDetails(
        date: dateParam,
        groupId: selectedGroup,
      );

      setState(() {
        // groupsList = response.groups ?? [];
        if (selectedGroup != null &&
            !groupsList.any((g) => g.id == selectedGroup)) {
          selectedGroup = null;
        }

        // ALERTS
        totalAlerts = response.totalAlerts ?? 0;
        criticalAlerts = response.criticalAlerts ?? 0;
        nonCriticalAlerts = response.nonCriticalAlerts ?? 0;
        attentionNeededVehicles = response.attentionNeededVehicles ?? 0;

        recentAlerts = response.alerts?.map((e) => e.toJson()).toList() ?? [];

        // ALERT GRAPHS
        alertsWeeklyGraph = response.weeklyAlertsGraph ?? [];
        alertsMonthlyGraph = response.monthlyAlertsGraph ?? [];
      });
    } catch (e) {
      debugPrint("Dashboard API error: $e");
    } finally {
<<<<<<< HEAD
      setState(() => isDashboardLoading = false);
    }
  }

  Future<void> fetchTripDetails() async {
    setState(() => isDashboardLoading = true);
=======
      if (showLoading) setState(() => isDashboardLoading = false);
    }
  }

  Future<void> fetchTripDetails({bool showLoading = true}) async {
    if (showLoading) setState(() => isDashboardLoading = true);
>>>>>>> c2ef342d8996b5efd33c2a858d85f2fad345860e

    try {
      final response = await _dashboardApi.fetchTripsDetails(
        date: dateParam,
        groupId: selectedGroup,
      );

      setState(() {
        // groupsList = response.groups ?? [];
        if (selectedGroup != null &&
            !groupsList.any((g) => g.id == selectedGroup)) {
          selectedGroup = null;
        }

        // VEHICLES

        // TRIPS
        tripsTotal = response.totalTrips ?? 0;
        completedTrips = response.completedTrips ?? 0;
        ongoingTrips = response.ongoingTrips ?? 0;
        totalDistance = response.totalDistanceKm ?? 0;
        totalOperHours = response.totalOperationalDuration ?? 0;
        avgTripsDay = response.avgTripsPerDay ?? 0;
        totalConsumedEnergy = response.totalEnergyConsumed ?? 0;
        todayTotalDistance = response.todayDistanceKm ?? 0;
        todayTotalOperHr = response.todayEnergyConsumed ?? 0;
        yesterdayTotalDistanceKm = response.yesterdayDistanceKm ?? 0;
        yesterdayTotalOperHr = response.yesterdayOperationalHours ?? 0;

        tripsWeeklyGraph = response.weeklyTripsGraph ?? [];
        tripsMonthlyGraph = response.monthlyTripsGraph ?? [];
      });
    } catch (e) {
      debugPrint("Dashboard API error: $e");
    } finally {
<<<<<<< HEAD
      setState(() => isDashboardLoading = false);
    }
  }

  Future<void> fetchVehicleDetails() async {
    setState(() => isDashboardLoading = true);
=======
      if (showLoading) setState(() => isDashboardLoading = false);
    }
  }

  Future<void> fetchVehicleDetails({bool showLoading = true}) async {
    if (showLoading) setState(() => isDashboardLoading = true);
>>>>>>> c2ef342d8996b5efd33c2a858d85f2fad345860e

    try {
      final response = await _dashboardApi.fetchVehicleDetails(
        date: dateParam,
        groupId: selectedGroup,
      );

      setState(() {
        // groupsList = response.groups ?? [];
        if (selectedGroup != null &&
            !groupsList.any((g) => g.id == selectedGroup)) {
          selectedGroup = null;
        }

        // VEHICLES
        totalVehicles = response.totalVehicles ?? 0;
        activeVehicles = response.activeVehicles ?? 0;
        inactiveVehicles = response.inactiveVehicles ?? 0;

        // STATUS
        moving = response.vehicleStatusMap!.moving ?? 0;
        idle = response.vehicleStatusMap!.idle ?? 0;
        stopped = response.vehicleStatusMap!.stopped ?? 0;
        disconnected = response.vehicleStatusMap!.disconnected ?? 0;
        nonCoverage = response.vehicleStatusMap!.noncoverage ?? 0;

        charging = response.vehicleStatusMap!.charging ?? 0;
<<<<<<< HEAD
        discharging = response.vehicleStatusMap!.disCharging ?? 0;
=======
        discharging = response.vehicleStatusMap!.discharging ?? 0;
>>>>>>> c2ef342d8996b5efd33c2a858d85f2fad345860e
        batteryIdle = response.vehicleStatusMap?.idle ?? 0;
        batteryDisconnected = response.vehicleStatusMap?.disconnected ?? 0;

        //BMS Stats
        bmsStatsExcellent = response.socSummary!.excellent ?? 0;
        bmsStatsGood = response.socSummary!.good ?? 0;
        bmsStatsModerate = response.socSummary!.moderate ?? 0;
        bmsStatsPoor = response.socSummary!.poor ?? 0;

        vehicleUtilizationWeeklyGraph = response.weeklyVehicleUtilization ?? [];
        vehicleUtilizationMonthlyGraph =
            response.monthlyVehicleUtilization ?? [];
      });
    } catch (e) {
      debugPrint("Dashboard API error: $e");
    } finally {
<<<<<<< HEAD
=======
      if (showLoading) setState(() => isDashboardLoading = false);
    }
  }

  Future<void> fetchAllDashboardData() async {
    setState(() => isDashboardLoading = true);
    try {
      await Future.wait([
        fetchAlertDetails(showLoading: false),
        fetchTripDetails(showLoading: false),
        fetchVehicleDetails(showLoading: false),
      ]);
    } catch (e) {
      debugPrint('Dashboard API error: $e');
    } finally {
>>>>>>> c2ef342d8996b5efd33c2a858d85f2fad345860e
      setState(() => isDashboardLoading = false);
    }
  }

  Map<String, dynamic>? dashboardData;
  bool isDashboardLoading = false;
  int totalVehicles = 0;
  int evtotalvehicles = 0;

  int moving = 0;
  int idle = 0;
  int stopped = 0;
  int nonCoverage = 0;
  int disconnected = 0;
  int charging = 0;
  int discharging = 0;
  int batteryIdle = 0;
  int batteryDisconnected = 0;

  int activeVehicles = 0;
  int inactiveVehicles = 0;
  int evActive = 0;
  int evInactive = 0;

  Map<String, dynamic>? tripFullDetails;

  int tripsTotal = 0;
  int completedTrips = 0;
  int ongoingTrips = 0;
  double totalDistance = 0;
  double totalOperHours = 0;
  double totalConsumedEnergy = 0;
  double avgTripsDay = 0;
  double avgOdoPerVehicle = 0;
  double avgConEngPerVehicle = 0;
  double todayTotalDistance = 0;
  double todayTotalOperHr = 0;
  double yesterdayTotalDistanceKm = 0;
  double yesterdayTotalOperHr = 0;

  int totalAlerts = 0;
  int criticalAlerts = 0;
  int nonCriticalAlerts = 0;
  int attentionNeededVehicles = 0;

  int bmsStatsExcellent = 0;
  int bmsStatsGood = 0;
  int bmsStatsModerate = 0;
  int bmsStatsPoor = 0;

  List<Map<String, dynamic>> recentAlerts = [];

  // List<AlertsGraph> alertsWeeklyGraph = [];
  // List<AlertGraphforMonth> alertsMonthlyGraph = [];

  List<WeeklyAlertsGraph> alertsWeeklyGraph = [];
  List<MonthlyAlertsGraph> alertsMonthlyGraph = [];

  // List<TripsGraph> tripsWeeklyGraph = [];
  // List<TripsGraphforMonth> tripsMonthlyGraph = [];

  List<WeeklyTripsGraph> tripsWeeklyGraph = [];
  List<MonthlyTripsGraph> tripsMonthlyGraph = [];

  // List<VehicleutliGraph> vehicleUtilizationWeeklyGraph = [];
  // List<VehicleutliGraphforMonth> vehicleUtilizationMonthlyGraph = [];

  List<WeeklyVehicleUtilization> vehicleUtilizationWeeklyGraph = [];
  List<MonthlyVehicleUtilization> vehicleUtilizationMonthlyGraph = [];

  List<Group> groupsList = [];

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
      // fetchDashboardDetails();
<<<<<<< HEAD
      fetchAlertDetails();
      fetchTripDetails();
      fetchVehicleDetails();
=======
      fetchAllDashboardData();
>>>>>>> c2ef342d8996b5efd33c2a858d85f2fad345860e
    }
  }

  double parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value.replaceAll(',', '')) ?? 0.0;
    }
    return 0.0;
  }

  List<Map<String, dynamic>> getBackendStatus() {
    final total = totalVehicles;
    if (total == 0) return [];

    double pct(int value) => (value / total) * 100;

    return [
      {
        'label': 'Moving',
        'color': tGreen,
        'count': moving,
        'percent': pct(moving),
      },
      {
        'label': 'Stopped',
        'color': tRed,
        'count': stopped,
        'percent': pct(stopped),
      },
      {'label': 'Idle', 'color': tOrange1, 'count': idle, 'percent': pct(idle)},
      {
        'label': 'Non Coverage',
        'color': Colors.purple,
        'count': nonCoverage,
        'percent': pct(nonCoverage),
      },
      {
        'label': 'Disconnected',
        'color': tGrey,
        'count': disconnected,
        'percent': pct(disconnected),
      },
    ];
  }

  List<Map<String, dynamic>> getEVBackendStatus() {
    final total = totalVehicles;
    if (total == 0) return [];

    double pct(int value) => (value / total) * 100;

    return [
      {
        'label': 'Charging',
        'color': tGreen,
        'count': charging,
        'percent': pct(charging),
      },
      {
        'label': 'Discharging',
        'color': tBlue,
        'count': discharging,
        'percent': pct(discharging),
      },
      {
        'label': 'Idle',
        'color': tOrange1,
        'count': batteryIdle,
        'percent': pct(batteryIdle),
      },
      {
        'label': 'Disconnected',
        'color': tGrey,
        'count': batteryDisconnected,
        'percent': pct(batteryDisconnected),
      },
    ];
  }

  String formatAlertDate(String? utc) {
    if (utc == null || utc.isEmpty) return '';
    final dateTime = DateTime.parse(utc).toLocal();
    return DateFormat('dd MMM yyyy, HH:mm:ss').format(dateTime);
  }

  @override
  void initState() {
    super.initState();
    // fetchDashboardDetails();
<<<<<<< HEAD
    fetchAlertDetails();
    fetchTripDetails();
    fetchVehicleDetails();
=======
    fetchAllDashboardData();
>>>>>>> c2ef342d8996b5efd33c2a858d85f2fad345860e
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileLayout(),
      tablet: Container(),
      desktop: _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mode = context.watch<FleetModeProvider>().mode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        FleetTitleBar(isDark: isDark, title: "Dashboard"),
        SizedBox(height: 10),
        _buildGroupSelector(isDark),
        const SizedBox(height: 10),
        _buildDateSelector(isDark),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mode = context.watch<FleetModeProvider>().mode;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // _buildTitle(isDark),
                FleetTitleBar(isDark: isDark, title: "Dashboard"),

                Row(
                  children: [
                    _buildGroupSelector(isDark),
                    const SizedBox(width: 10),
                    _buildDateSelector(isDark),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: [
                          // Total Vehicles Main Card
                          GestureDetector(
                            onTap: () {
                              context.go('/home/devices');
                            },
                            child: LargeHoverCard(
                              value:
                                  mode == 'EV Fleet'
                                      ? '$totalVehicles'
                                      : "$totalVehicles", //value: "5,673",
<<<<<<< HEAD
                              label: "Vehicles",
=======
                              label: "Total Vehicles",
>>>>>>> c2ef342d8996b5efd33c2a858d85f2fad345860e
                              labelColor: tBlue,
                              icon: "icons/car.svg",
                              iconColor: tBlue,
                              bgColor: tBlue.withOpacity(0.1),
                              isDark: isDark,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                SmallHoverCard(
                                  width: double.infinity,
                                  height: 87,
                                  value:
                                      mode == 'EV Fleet'
                                          ? "$activeVehicles"
                                          : "$activeVehicles", //value: "124",
                                  label: "Active Vehicles",
                                  labelColor: tGreen,
                                  icon: "icons/car.svg",
                                  iconColor: tGreen,
                                  bgColor: tGreen.withOpacity(0.1),
                                  isDark: isDark,
                                ),
                                const SizedBox(height: 11),
                                SmallHoverCard(
                                  width: double.infinity,
                                  height: 87,
                                  value:
                                      mode == 'EV Fleet'
                                          ? "$inactiveVehicles"
                                          : "$inactiveVehicles", // value: "53",
                                  label: "Inactive Vehicles",
                                  labelColor: tRed,
                                  icon: "icons/car.svg",
                                  iconColor: tRed,
                                  bgColor: tRed.withOpacity(0.1),
                                  isDark: isDark,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),

                          /// 🔹 Middle: Vehicle Status Bars
                          Expanded(
                            flex: 8,
                            child: Container(
                              height: 185,
                              decoration: BoxDecoration(
                                color: isDark ? tBlack : tWhite,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                    color:
                                        isDark
                                            ? tWhite.withOpacity(0.12)
                                            : tBlack.withOpacity(0.1),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                top: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mode == 'EV Fleet'
                                        ? 'EV Vehicle Status'
                                        : 'Vehicle Status',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 13,
                                      color: isDark ? tWhite : tBlack,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // If EV mode → show EV status, else show normal status
                                  mode == 'EV Fleet'
                                      ? DynamicSegmentBar(
                                        statuses:
                                            getEVBackendStatus(), // or getEVBackendStatus()
                                        height: 26,
                                      )
                                      //  _buildMobileDynamicStatusBar(
                                      //   getEVBackendStatus(),
                                      // )
                                      : DynamicSegmentBar(
                                        statuses:
                                            getBackendStatus(), // or getEVBackendStatus()
                                        height: 26,
                                      ),
                                  //_buildDynamicStatusBar(getBackendStatus()),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          GestureDetector(
                            onTap: () {
                              context.go('/home/trips');
                            },
                            child: LargeHoverCard(
                              value: tripsTotal.toString(), //value: "50,678",
                              label: "Trips",
                              labelColor: tGreen,
                              icon: "icons/distance.svg",
                              iconColor: tGreen,
                              bgColor: tGreen.withOpacity(0.1),
                              isDark: isDark,
                            ),
                          ),
                        ],
                      ),
                      if (mode == "EV Fleet") ...[
                        const SizedBox(height: 10),
                        Text(
                          'Batteries Status',
                          style: GoogleFonts.urbanist(
                            fontSize: 13,
                            color: isDark ? tWhite : tBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: isDark ? tBlack : tWhite,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color:
                                    isDark
                                        ? tWhite.withOpacity(0.25)
                                        : tBlack.withOpacity(0.15),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(15),
                          child: BatteryProgressBar(
                            counts: [
                              bmsStatsExcellent,
                              bmsStatsGood,
                              bmsStatsModerate,
                              bmsStatsPoor,
                            ],
                            showLabels: true,
                          ),
                        ),
                      ],

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          // LEFT SIDE (Flex 8)
                          Expanded(
                            flex: 8,
                            child: Column(
                              children: [
                                // --------------------- ALERTS OVERVIEW ---------------------
                                Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: tTransparent,
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     blurRadius: 12,
                                    //     spreadRadius: 2,
                                    //     color:
                                    //         isDark
                                    //             ? tWhite.withOpacity(0.12)
                                    //             : tBlack.withOpacity(0.1),
                                    //   ),
                                    // ],
                                  ),
                                  // padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Alerts Overview',
                                        style: GoogleFonts.urbanist(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: isDark ? tWhite : tBlack,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                // ---------------- FIRST ROW (Large Cards) ----------------
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          context.go(
                                                            '/home/alerts',
                                                          );
                                                        },
                                                        child: LargeHoverCard(
                                                          value:
                                                              totalAlerts
                                                                  .toString(), //value: "756",
                                                          label: "Alerts",
                                                          labelColor: tRed,
                                                          icon:
                                                              "icons/alert.svg",
                                                          iconColor: tRed,
                                                          bgColor: tRed
                                                              .withOpacity(0.1),
                                                          isDark: isDark,
                                                          height: 185,
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(width: 10),

                                                    Expanded(
                                                      child: LargeHoverCard(
                                                        value:
                                                            attentionNeededVehicles
                                                                .toString(),
                                                        label: "Faults",
                                                        labelColor: tPink,
                                                        icon:
                                                            "icons/flagged.svg",
                                                        iconColor: tPink,
                                                        bgColor: tPink
                                                            .withOpacity(0.1),
                                                        isDark: isDark,
                                                        height: 185,
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(height: 10),

                                                // ---------------- SECOND ROW (Small Cards) ----------------
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: SmallHoverCard(
                                                        height: 74,
                                                        value:
                                                            nonCriticalAlerts
                                                                .toString(),
                                                        label:
                                                            "Non-Critical Alerts",
                                                        labelColor: tBlueSky,
                                                        icon: "icons/alert.svg",
                                                        iconColor: tBlueSky,
                                                        bgColor: tBlueSky
                                                            .withOpacity(0.1),
                                                        isDark: isDark,
                                                      ),
                                                    ),

                                                    SizedBox(width: 10),

                                                    Expanded(
                                                      child: SmallHoverCard(
                                                        height: 74,
                                                        value:
                                                            criticalAlerts
                                                                .toString(),
                                                        label:
                                                            "Critical Alerts",
                                                        labelColor: tOrange1,
                                                        icon: "icons/alert.svg",
                                                        iconColor: tOrange1,
                                                        bgColor: tOrange1
                                                            .withOpacity(0.1),
                                                        isDark: isDark,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(width: 10),

                                          // ---------------- DONUT CHART CONTAINER ----------------
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 270,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: isDark ? tBlack : tWhite,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 12,
                                                    spreadRadius: 2,
                                                    color:
                                                        isDark
                                                            ? tWhite
                                                                .withOpacity(
                                                                  0.12,
                                                                )
                                                            : tBlack
                                                                .withOpacity(
                                                                  0.08,
                                                                ),
                                                  ),
                                                ],
                                              ),
                                              child: AlertsDonutChart(
                                                critical: criticalAlerts,
                                                nonCritical: nonCriticalAlerts,
                                                avgCritical:
                                                    ((criticalAlerts * 100) /
                                                            (totalAlerts == 0
                                                                ? 1
                                                                : totalAlerts))
                                                        .toInt(),
                                                avgNonCritical:
                                                    ((nonCriticalAlerts * 100) /
                                                            (totalAlerts == 0
                                                                ? 1
                                                                : totalAlerts))
                                                        .toInt(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 10),

                                // --------------------- TRIPS OVERVIEW ---------------------
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: tTransparent,
                                    // color: isDark ? tBlack : tWhite,
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     blurRadius: 12,
                                    //     spreadRadius: 2,
                                    //     color:
                                    //         isDark
                                    //             ? tWhite.withOpacity(0.12)
                                    //             : tBlack.withOpacity(0.1),
                                    //   ),
                                    // ],
                                  ),
                                  // padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Trips Overview',
                                        style: GoogleFonts.urbanist(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: isDark ? tWhite : tBlack,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                SmallHoverCard(
                                                  width: double.infinity,
                                                  height: 75,
                                                  value:
                                                      completedTrips.toString(),
                                                  label: "Completed Trips",
                                                  labelColor: tBlue,
                                                  icon: "icons/completed.svg",
                                                  iconColor: tBlue,
                                                  bgColor: tBlue.withOpacity(
                                                    0.1,
                                                  ),
                                                  isDark: isDark,
                                                ),
                                                const SizedBox(height: 10),
                                                SmallHoverCard(
                                                  width: double.infinity,
                                                  height: 75,
                                                  value:
                                                      ongoingTrips.toString(),
                                                  label: "Ongoing Trips",
                                                  labelColor: tOrange1,
                                                  icon: "icons/ongoing.svg",
                                                  iconColor: tOrange1,
                                                  bgColor: tOrange1.withOpacity(
                                                    0.1,
                                                  ),
                                                  isDark: isDark,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                SmallHoverCard(
                                                  width: double.infinity,
                                                  height: 75,
                                                  value: avgTripsDay.toString(),
                                                  label: "Avg. Trips",
                                                  labelColor: tBlueSky,
                                                  icon: "icons/distance.svg",
                                                  iconColor: tBlueSky,
                                                  bgColor: tBlueSky.withOpacity(
                                                    0.1,
                                                  ),
                                                  isDark: isDark,
                                                ),
                                                const SizedBox(height: 10),

                                                mode == 'EV Fleet'
                                                    ? SmallHoverCard(
                                                      width: double.infinity,
                                                      height: 75,
                                                      value:
                                                          totalConsumedEnergy
                                                              .toString(),
                                                      label: "Consumed Energy",
                                                      labelColor: tBlue1,
                                                      icon: "icons/battery.svg",
                                                      iconColor: tBlue1,
                                                      bgColor: tBlue1
                                                          .withOpacity(0.1),
                                                      isDark: isDark,
                                                    )
                                                    : SmallHoverCard(
                                                      width: double.infinity,
                                                      height: 75,
                                                      value: "--",
                                                      label: "Consumed Fuel(L)",
                                                      labelColor: tRed,
                                                      icon: "icons/fuel.svg",
                                                      iconColor: tRed,
                                                      bgColor: tRed.withOpacity(
                                                        0.1,
                                                      ),
                                                      isDark: isDark,
                                                    ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                SmallHoverCard(
                                                  width: double.infinity,
                                                  height: 75,
                                                  value:
                                                      todayTotalDistance
                                                          .toString(),
                                                  label: "Today's Distance(km)",
                                                  labelColor: tGreenDark,
                                                  icon: "icons/distance.svg",
                                                  iconColor: tGreenDark,
                                                  bgColor: tGreenDark
                                                      .withOpacity(0.1),
                                                  isDark: isDark,
                                                ),
                                                const SizedBox(height: 10),
                                                SmallHoverCard(
                                                  width: double.infinity,
                                                  height: 75,
                                                  value:
                                                      todayTotalOperHr
                                                          .toString(),
                                                  label:
                                                      "Today's Oper. Hours(hrs)",
                                                  labelColor: tPink,
                                                  icon:
                                                      "icons/consumedhours.svg",
                                                  iconColor: tPink,
                                                  bgColor: tPink.withOpacity(
                                                    0.1,
                                                  ),
                                                  isDark: isDark,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),

                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                SmallHoverCard(
                                                  width: double.infinity,
                                                  height: 75,
                                                  value:
                                                      yesterdayTotalDistanceKm
                                                          .toString(),
                                                  label: "Yest. Distance(km)",
                                                  labelColor: tGreen,
                                                  icon: "icons/distance.svg",
                                                  iconColor: tGreen,
                                                  bgColor: tGreen.withOpacity(
                                                    0.1,
                                                  ),
                                                  isDark: isDark,
                                                ),
                                                const SizedBox(height: 10),
                                                SmallHoverCard(
                                                  width: double.infinity,
                                                  height: 75,
                                                  value:
                                                      yesterdayTotalOperHr
                                                          .toString(),
                                                  label:
                                                      "Yest. Oper. Hours(hrs)",
                                                  labelColor:
                                                      Colors.purpleAccent,
                                                  icon:
                                                      "icons/consumedhours.svg",
                                                  iconColor:
                                                      Colors.purpleAccent,
                                                  bgColor: Colors.purpleAccent
                                                      .withOpacity(0.1),
                                                  isDark: isDark,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 10),

                          Expanded(
                            flex: 4,
                            child: Container(
                              height: 510,
                              decoration: BoxDecoration(
                                color: tTransparent,
                                // color: isDark ? tBlack : tWhite,
                                // boxShadow: [
                                //   BoxShadow(
                                //     blurRadius: 12,
                                //     spreadRadius: 2,
                                //     color:
                                //         isDark
                                //             ? tWhite.withOpacity(0.12)
                                //             : tBlack.withOpacity(0.1),
                                //   ),
                                // ],
                              ),
                              // padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Recent Alerts',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? tWhite : tBlack,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  /// Scrollable content must be wrapped in Expanded
                                  Expanded(child: buildAlertsTable(isDark)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              height: 325,
                              decoration: BoxDecoration(
                                color: isDark ? tBlack : tWhite,
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color:
                                        isDark
                                            ? tWhite.withOpacity(0.25)
                                            : tBlack.withOpacity(0.15),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(15),
                              child: TripsChart(
                                weeklyData: tripsWeeklyGraph,
                                monthlyData: tripsMonthlyGraph,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 4,
                            child: Container(
                              height: 325,
                              decoration: BoxDecoration(
                                color: isDark ? tBlack : tWhite,
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color:
                                        isDark
                                            ? tWhite.withOpacity(0.25)
                                            : tBlack.withOpacity(0.15),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(15),
                              child: VehicleUtilizationChart(
                                weeklyData: vehicleUtilizationWeeklyGraph,
                                monthlyData: vehicleUtilizationMonthlyGraph,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 4,
                            child: Container(
                              height: 325,
                              decoration: BoxDecoration(
                                color: isDark ? tBlack : tWhite,
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color:
                                        isDark
                                            ? tWhite.withOpacity(0.25)
                                            : tBlack.withOpacity(0.15),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(15),
                              child: AlertsChart(
                                weeklyData: alertsWeeklyGraph,
                                monthlyData: alertsMonthlyGraph,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        if (isDashboardLoading) _buildLoadingOverlay(isDark),
      ],
    );
  }

  Widget _buildGroupSelector(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildLabelBox("Group Name", tBlue, isDark),
            const SizedBox(width: 5),
            _buildDynamicDropdown(isDark),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          '(Note: Filter by Group Name)',
          style: GoogleFonts.urbanist(
            fontSize: 10,
            color: isDark ? tWhite.withOpacity(0.6) : tBlack.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildLabelBox("Date", tBlue, isDark),
            const SizedBox(width: 5),
            _buildDynamicDatePicker(isDark),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          '(Note: Filter by Date)',
          style: GoogleFonts.urbanist(
            fontSize: 10,
            color: isDark ? tWhite.withOpacity(0.6) : tBlack.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLabelBox(String text, Color textColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: tTransparent,
        border: Border.all(width: 0.5, color: isDark ? tWhite : tBlack),
      ),
      child: Text(
        text,
        style: GoogleFonts.urbanist(
          fontSize: 12,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDynamicDropdown(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: tTransparent,
        border: Border.all(width: 0.6, color: isDark ? tWhite : tBlack),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: false,
          hint: Text(
            'Select Group',
            style: GoogleFonts.urbanist(fontSize: 12.5, color: tGrey),
          ),
          items:
              groupsList
                  .map(
                    (group) => DropdownMenuItem<String>(
                      value: group.id,
                      child: Text(
                        group.name ?? '',
                        style: GoogleFonts.urbanist(
                          fontSize: 12.5,
                          color: isDark ? tWhite : tBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                  .toList(),
          value: selectedGroup,
          onChanged: (value) {
            setState(() {
              selectedGroup = value;
            });
            // fetchDashboardDetails();
<<<<<<< HEAD
            fetchAlertDetails();
            fetchTripDetails();
            fetchVehicleDetails();
=======
            fetchAllDashboardData();
>>>>>>> c2ef342d8996b5efd33c2a858d85f2fad345860e
          },
          iconStyleData: IconStyleData(
            icon: Icon(
              CupertinoIcons.chevron_down,
              size: 16,
              color: isDark ? tWhite : tBlack,
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            padding: EdgeInsets.zero,
            maxHeight: 200,
            decoration: BoxDecoration(
              color: isDark ? tBlack : tWhite,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 10,
                  color:
                      isDark
                          ? tWhite.withOpacity(0.25)
                          : tBlack.withOpacity(0.15),
                ),
              ],
            ),
          ),
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.zero,
            height: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicDatePicker(bool isDark) {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: tTransparent,
          border: Border.all(width: 0.6, color: isDark ? tWhite : tBlack),
        ),
        child: Text(
          // DateFormat('dd MMM yyyy').format(selectedDate!).toUpperCase(),
          selectedDate == null
              ? 'SELECT DATE'
              : DateFormat('dd MMM yyyy').format(selectedDate!).toUpperCase(),
          style: GoogleFonts.urbanist(
            fontSize: 12.5,
            color: isDark ? tWhite : tBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildAlertsTable(bool isDark) {
    final alerts = recentAlerts;

    Color getAlertColor(String type) {
      type = type.toLowerCase();
      if (type.contains('disconnect')) return tRedDark;
      if (type.contains('battery')) return Colors.red.shade400;
      if (type.contains('low') || type.contains('low_fuel')) return tOrange1;
      if (type.contains('temperature') || type.contains('temp')) {
        return Colors.deepOrange;
      }
      if (type.contains('fall')) {
        return Colors.purple;
      }
      if (type.contains('ignition')) return tBlueSky;
      if (type.contains('speed')) return Colors.teal;
      if (type.contains('tilt')) return Colors.indigo;

      return tGreen3;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        final maxWidth = constraints.maxWidth;

        return Container(
          width: maxWidth,
          height: maxHeight,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isDark ? tBlack : tWhite,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: isDark ? Colors.white24 : Colors.black12,
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Scrollbar(
                  controller: _horizontalController,
                  thumbVisibility: true,
                  radius: const Radius.circular(6),
                  thickness: 4,
                  child: SingleChildScrollView(
                    controller: _horizontalController,
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: maxWidth),
                      child: Scrollbar(
                        controller: _verticalController,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          controller: _verticalController,
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            headingRowColor: WidgetStateProperty.all(
                              isDark
                                  ? tBlue.withOpacity(0.15)
                                  : tBlue.withOpacity(0.05),
                            ),
                            headingTextStyle: GoogleFonts.urbanist(
                              fontWeight: FontWeight.w700,
                              color: isDark ? tWhite : tBlack,
                              fontSize: 13,
                            ),
                            dataTextStyle: GoogleFonts.urbanist(
                              color: isDark ? tWhite : tBlack,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                            columnSpacing: 35,
                            border: TableBorder.all(
                              color:
                                  isDark
                                      ? tWhite.withOpacity(0.1)
                                      : tBlack.withOpacity(0.1),
                              width: 0.4,
                            ),
                            dividerThickness: 0.01,
                            columns: const [
                              DataColumn(label: Text("Vehicle / IMEI")),
                              DataColumn(label: Text("Date & Time")),
                              DataColumn(label: Text("Alert Type")),
                            ],
                            rows:
                                alerts.map((alert) {
                                  final alertType =
                                      (alert['alertType'] ?? '').toString();
                                  final alertColor = getAlertColor(
                                    alert['alertType']!,
                                  );

                                  return DataRow(
                                    cells: [
                                      // Vehicle + IMEI column
                                      DataCell(
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              (alert['vehicleNumber'] ?? '')
                                                  .toString(),
                                              style: GoogleFonts.urbanist(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              (alert['imei'] ?? '').toString(),
                                              style: GoogleFonts.urbanist(
                                                fontSize: 11,
                                                color:
                                                    isDark
                                                        ? Colors.grey[300]
                                                        : Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // DateTime
                                      DataCell(
                                        Text(
                                          formatDateTime(
                                            alert['time'] ?? '',
                                          ).toString(),
                                        ),
                                      ),

                                      // Alert Type Badge
                                      DataCell(
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                            horizontal: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: alertColor.withOpacity(0.18),
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: Text(
                                            alertType,
                                            style: GoogleFonts.urbanist(
                                              color: alertColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingOverlay(bool isDark) {
    return Positioned.fill(
      child: AbsorbPointer(
        absorbing: true, // block all touches
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            color: tBlack.withOpacity(isDark ? 0.35 : 0.15),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/gifs/loading1.json',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                    repeat: true,
                  ),

                  Text(
                    'Loading Dashboard...',
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? tWhite : tBlack,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
