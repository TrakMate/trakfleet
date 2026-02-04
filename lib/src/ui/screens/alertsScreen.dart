import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:tm_fleet_management/src/utils/appColors.dart';

import '../../models/alertsModel.dart';
import '../../services/generalAPIServices.dart/alertsAPIService.dart';
import '../../utils/appResponsive.dart';
import '../components/customTitleBar.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  DateTime selectedDate = DateTime.now();

  int hoveredAlertIndex = -1; // add this above build()

  final AlertsApiService _apiService = AlertsApiService();

  AlertsModel? alertsModel;
  bool isLoading = false;

  int currentPage = 1;
  int rowsPerPage = 10;
  int totalPages = 1;

  Future<void> fetchAlerts() async {
    if (!mounted) return;

    setState(() => isLoading = true);

    try {
      final result = await _apiService.fetchAlerts(
        currentIndex: (currentPage - 1) * rowsPerPage,
        sizePerPage: rowsPerPage,
      );

      if (!mounted) return;

      setState(() {
        alertsModel = result;
        totalPages = ((result.totalAlerts ?? 0) / rowsPerPage).ceil();
      });
    } catch (e) {
      debugPrint("Alerts API Error: $e");
    } finally {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) fetchAlerts();
    });
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  Map<String, double> _buildFaultData(Set<String> faultTypes) {
    final rand = Random();

    final selected = faultTypes.take(4).toList();
    final Map<String, double> result = {};

    double remaining = 100;

    for (int i = 0; i < selected.length; i++) {
      final value =
          i == selected.length - 1 ? remaining : rand.nextInt(30) + 10;

      result[selected[i]] = value.toDouble();
      remaining -= value;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ResponsiveLayout(
      mobile: _buildMobileLayout(),
      tablet: _buildTabletLayout(),
      desktop: _buildDesktopLayout(isDark),
    );
  }

  Widget _buildMobileLayout() {
    return Container();
  }

  Widget _buildTabletLayout() {
    return Container();
  }

  Widget _buildDesktopLayout(bool isDark) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // _buildTitle(isDark),
                FleetTitleBar(isDark: isDark, title: "Alerts"),

                Row(
                  children: [
                    _buildFilterBySearch(isDark),
                    SizedBox(width: 10),
                    _buildDynamicDatePicker(isDark),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  Expanded(flex: 4, child: _buildAlertsOverview(isDark)),
                  const SizedBox(width: 10),
                  Expanded(flex: 6, child: _buildAlertsTable(isDark)),
                ],
              ),
            ),
          ],
        ),
        if (isLoading) _buildLoadingOverlay(isDark),
      ],
    );
  }

  Widget _buildFilterBySearch(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 250,
          height: 40,
          decoration: BoxDecoration(
            color: tTransparent,
            border: Border.all(color: isDark ? tWhite : tBlack, width: 1),
          ),
          child: TextField(
            style: GoogleFonts.urbanist(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDark ? tWhite : tBlack,
            ),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: GoogleFonts.urbanist(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDark ? tWhite : tBlack,
              ),
              border: InputBorder.none,
              prefixIcon: Icon(
                CupertinoIcons.search,
                color: isDark ? tWhite : tBlack,
                size: 18,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '(Note: Filter by Search)',
          style: GoogleFonts.urbanist(
            fontSize: 10,
            color: isDark ? tWhite.withOpacity(0.6) : tBlack.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicDatePicker(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _selectDate,
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: tTransparent,
              border: Border.all(width: 0.6, color: isDark ? tWhite : tBlack),
            ),
            child: Center(
              child: Text(
                DateFormat('dd MMM yyyy').format(selectedDate).toUpperCase(),
                style: GoogleFonts.urbanist(
                  fontSize: 12.5,
                  color: isDark ? tWhite : tBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
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

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder:
          (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: child!,
          ),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  Widget _buildAlertsTable(bool isDark) {
    // Define color mapping for each alert type
    final Map<String, Color> alertColors = {
      'PowerDisconnect': Colors.redAccent,
      'BatteryDisconnect': Colors.orangeAccent,
      'Speed': Colors.deepOrange,
      'Ignition On': Colors.green,
      'Ignition Off': Colors.grey,
      'Geo Fence Alert': Colors.purpleAccent,
      'Battery Low': Colors.amber,
      'Tilt': Colors.blueAccent,
      'Fall': Colors.pinkAccent,
      'SOSTriggered': Colors.red,
    };

    final alerts = alertsModel?.alerts ?? [];

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        final maxWidth = constraints.maxWidth;

        return Container(
          width: maxWidth,
          height: maxHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scrollable Table Area
              Expanded(
                child: Scrollbar(
                  controller: _horizontalController,
                  thumbVisibility: true,
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
                            columnSpacing: 30,
                            border: TableBorder.all(
                              color:
                                  isDark
                                      ? tWhite.withOpacity(0.1)
                                      : tBlack.withOpacity(0.1),
                              width: 0.4,
                            ),
                            dividerThickness: 0.01,
                            columns: const [
                              DataColumn(label: Text('IMEI Number')),
                              DataColumn(label: Text('Vehicle ID')),
                              DataColumn(label: Text('Alert Time')),
                              DataColumn(label: Text('Alert Type')),
                              DataColumn(label: Text('Alert Data')),
                            ],
                            rows:
                                alerts.map((alert) {
                                  final isCritical =
                                      alert.alertCategory == "CRITICAL";
                                  final color =
                                      alertColors[alert.alertType] ??
                                      (isDark ? tBlue : Colors.blueGrey);

                                  return DataRow(
                                    cells: [
                                      DataCell(Text(alert.imei ?? "--")),
                                      DataCell(
                                        Text(alert.vehicleNumber ?? "--"),
                                      ),
                                      DataCell(
                                        Text(
                                          DateFormat(
                                            'dd MMM yyyy, hh:mm a',
                                          ).format(
                                            DateTime.parse(
                                              alert.time!,
                                            ).toLocal(),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Small circular critical/non-critical indicator
                                            Container(
                                              width: 10,
                                              height: 10,
                                              margin: const EdgeInsets.only(
                                                right: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                    isCritical
                                                        ? tOrange1
                                                        : tBlueSky,

                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        isCritical
                                                            ? tOrange1
                                                                .withOpacity(
                                                                  0.4,
                                                                )
                                                            : tBlueSky
                                                                .withOpacity(
                                                                  0.4,
                                                                ),
                                                    blurRadius: 4,
                                                    spreadRadius: 1,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Alert type colored container
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 4,
                                                    horizontal: 10,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: color.withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: color.withOpacity(0.6),
                                                  width: 0.8,
                                                ),
                                              ),
                                              child: Text(
                                                alert.alertType ?? "--",
                                                style: GoogleFonts.urbanist(
                                                  color: color,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DataCell(Text(alert.data ?? "--")),
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

              // Pagination Controls
              if (totalPages > 1) _buildPaginationControls(isDark),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAlertsOverview(bool isDark) {
    final Map<String, double> criticalAlerts = {
      'Power Disconnect': 30,
      'Battery Low': 25,
      'Tilt Alert': 20,
      'Fall Detected': 15,
      'SOS Triggered': 10,
    };

    final Map<String, double> nonCriticalAlerts = {
      'GPRS Lost': 20,
      'Over Speed': 30,
      'Ignition On': 25,
      'Ignition Off': 15,
      'Geo Fence Alert': 10,
    };

    final Map<String, Color> alertColors = {
      'Power Disconnect': Colors.redAccent,
      'Battery Low': Colors.orange,
      'Tilt Alert': Colors.pinkAccent,
      'Fall Detected': Colors.deepOrange,
      'SOS Triggered': Colors.red,
      'GPRS Lost': Colors.lightBlue,
      'Over Speed': Colors.green,
      'Ignition On': Colors.teal,
      'Ignition Off': Colors.cyan,
      'Geo Fence Alert': Colors.purple,
    };

    /// ========= FAULT GROUPS =========

    const Set<String> bmsFaultTypes = {
      'Battery Low',
      'Battery Disconnect',
      'Cell Voltage High',
      'Cell Voltage Low',
      'Cell Temperature High',
      'BMS Fault',
      'Battery Over Voltage',
      'Battery Under Voltage',
    };

    const Set<String> mcuFaultTypes = {
      'Motor Over Temperature',
      'Motor Controller Fault',
      'Inverter Fault',
      'MCU Fault',
      'Phase Failure',
    };

    const Set<String> ecuFaultTypes = {
      'ECU Fault',
      'CAN Error',
      'Sensor Fault',
      'Communication Error',
      'Throttle Fault',
    };

    final Map<String, Color> bmsFaultColors = {
      'Battery Low': Colors.orange,
      'Battery Disconnect': Colors.redAccent,
      'Cell Voltage High': Colors.deepOrange,
      'Cell Voltage Low': Colors.amber,
      'Cell Temperature High': Colors.pinkAccent,
      'BMS Fault': Colors.red,
    };

    final Map<String, Color> mcuFaultColors = {
      'Motor Over Temperature': Colors.deepOrange,
      'Motor Controller Fault': Colors.redAccent,
      'Inverter Fault': Colors.purple,
      'MCU Fault': Colors.red,
      'Phase Failure': Colors.orange,
    };

    final Map<String, Color> ecuFaultColors = {
      'ECU Fault': Colors.blueGrey,
      'CAN Error': Colors.indigo,
      'Sensor Fault': Colors.teal,
      'Communication Error': Colors.blue,
      'Throttle Fault': Colors.cyan,
    };

    final Set<String> allFaultTypes = {
      ...bmsFaultTypes,
      ...mcuFaultTypes,
      ...ecuFaultTypes,
    };

    final Map<String, Color> allFaultColors = {
      ...bmsFaultColors,
      ...mcuFaultColors,
      ...ecuFaultColors,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildAlertInfoCard(
              index: 0,
              title: 'Total Alerts',
              count: alertsModel?.totalAlerts?.toString() ?? "0",
              iconPath: 'icons/alert.svg',
              iconColor: tBlue,
              bgColor: tBlue.withOpacity(0.1),
              isDark: isDark,
            ),
            const SizedBox(width: 10),
            _buildAlertInfoCard(
              index: 1,
              title: 'Vehicle Faults',
              count: alertsModel?.attentionNeededVehicles?.toString() ?? '0',
              iconPath: 'icons/flagged.svg',
              iconColor: tRed,
              bgColor: tRed.withOpacity(0.1),
              isDark: isDark,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildAlertInfoCard(
              index: 2,
              title: 'Critical Alerts',
              count: alertsModel?.criticalAlerts?.toString() ?? '0',
              iconPath: 'icons/alert.svg',
              iconColor: tOrange1,
              bgColor: tOrange1.withOpacity(0.1),
              isDark: isDark,
            ),
            const SizedBox(width: 10),
            _buildAlertInfoCard(
              index: 3,
              title: 'Non-Critical Alerts',
              count: alertsModel?.nonCriticalAlerts?.toString() ?? '0',
              iconPath: 'icons/alert.svg',
              iconColor: tBlueSky,
              bgColor: tBlueSky.withOpacity(0.1),
              isDark: isDark,
            ),
          ],
        ),
        const SizedBox(height: 15),
        // AlertsPieChart(),
        Text(
          'Critical Alerts',
          style: GoogleFonts.urbanist(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isDark ? tWhite : tBlack,
          ),
        ),
        const SizedBox(height: 10),
        _buildAnimatedAlertsBar(criticalAlerts, alertColors, isDark),
        const SizedBox(height: 10),
        _buildLegends(criticalAlerts, alertColors, isDark),

        const SizedBox(height: 20),

        // ===== Non-Critical Alerts =====
        Text(
          'Non-Critical Alerts',
          style: GoogleFonts.urbanist(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isDark ? tWhite : tBlack,
          ),
        ),
        const SizedBox(height: 10),
        _buildAnimatedAlertsBar(nonCriticalAlerts, alertColors, isDark),
        const SizedBox(height: 10),
        _buildLegends(nonCriticalAlerts, alertColors, isDark),

        SizedBox(height: 20),
        // ===== Fault Sections =====
        _buildFaultSection(
          title: 'Vehicle Faults Overview',
          faultTypes: allFaultTypes,
          colors: allFaultColors,
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildFaultSection({
    required String title,
    required Set<String> faultTypes,
    required Map<String, Color> colors,
    required bool isDark,
  }) {
    final data = _buildFaultData(faultTypes);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.urbanist(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isDark ? tWhite : tBlack,
          ),
        ),
        const SizedBox(height: 10),

        if (data.isEmpty)
          Text(
            'No faults detected',
            style: GoogleFonts.urbanist(
              fontSize: 12,
              color: isDark ? tWhite.withOpacity(0.6) : tBlack.withOpacity(0.6),
            ),
          )
        else ...[
          _buildAnimatedAlertsBar(data, colors, isDark),
          const SizedBox(height: 10),
          _buildLegends(data, colors, isDark),
        ],

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildAnimatedAlertsBar(
    Map<String, double> data,
    Map<String, Color> colors,
    bool isDark,
  ) {
    double total = data.values.fold(0, (a, b) => a + b);

    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        color: tTransparent,
        // border: Border.all(width: 0.3, color: isDark ? tWhite : tBlack),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:
            data.entries.map((entry) {
              double percentage = entry.value / total;

              return TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: percentage),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Expanded(
                    flex: (value * 1000).toInt().clamp(1, 1000),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors[entry.key] ?? tGrey,
                        boxShadow: [
                          BoxShadow(
                            color:
                                (colors[entry.key]?.withOpacity(0.4)) ??
                                tGrey.withOpacity(0.4),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Tooltip(
                        message:
                            "${entry.key}: ${(entry.value).toStringAsFixed(1)}%",
                        child: const SizedBox.expand(),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
      ),
    );
  }

  // Legends Row
  Widget _buildLegends(
    Map<String, double> data,
    Map<String, Color> colors,
    bool isDark,
  ) {
    return Wrap(
      spacing: 10,
      runSpacing: 6,
      children:
          data.keys.map((key) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: colors[key] ?? Colors.grey,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  key,
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    color: isDark ? tWhite : tBlack,
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildAlertInfoCard({
    required int index,
    required String title,
    required String count,
    required String iconPath,
    required Color iconColor,
    required Color bgColor,
    required bool isDark,
  }) {
    final isHovered = hoveredAlertIndex == index;

    return Expanded(
      child: MouseRegion(
        onEnter: (_) => setState(() => hoveredAlertIndex = index),
        onExit: (_) => setState(() => hoveredAlertIndex = -1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isDark ? tBlack : tWhite,
            border: Border.all(
              width: isHovered ? 1.3 : 0.6,
              color:
                  isHovered
                      ? iconColor.withOpacity(0.7)
                      : iconColor.withOpacity(0.4),
            ),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: isHovered ? 14 : 10,
                color:
                    isDark
                        ? tWhite.withOpacity(0.12)
                        : tBlack.withOpacity(0.08),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconPath,
                    width: 20,
                    height: 20,
                    color: iconColor,
                  ),
                ),
              ),

              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.urbanist(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? tWhite : tBlack,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    count,
                    style: GoogleFonts.urbanist(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: iconColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationControls(bool isDark) {
    const int visiblePageCount = 5;

    // Determine start and end of visible window
    int startPage =
        ((currentPage - 1) ~/ visiblePageCount) * visiblePageCount + 1;
    int endPage = (startPage + visiblePageCount - 1).clamp(1, totalPages);

    final pageButtons = <Widget>[];

    for (int pageNum = startPage; pageNum <= endPage; pageNum++) {
      final isSelected = pageNum == currentPage;

      pageButtons.add(
        GestureDetector(
          onTap: () {
            if (!mounted) return;
            setState(() => currentPage = pageNum);
            fetchAlerts();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? tBlue : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color:
                    isSelected
                        ? tBlue
                        : (isDark ? Colors.white54 : Colors.black54),
              ),
            ),
            child: Text(
              '$pageNum',
              style: GoogleFonts.urbanist(
                color:
                    isSelected
                        ? tWhite
                        : (isDark
                            ? tWhite.withOpacity(0.8)
                            : tBlack.withOpacity(0.8)),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ),
      );
    }

    final controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Previous Button
          IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: isDark ? tWhite : tBlack,
              size: 22,
            ),
            onPressed: () {
              if (!mounted || currentPage <= 1) return;
              setState(() => currentPage--);
              fetchAlerts();
            },
          ),

          /// Page Buttons (windowed 5)
          Row(children: pageButtons),

          /// Next Button
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: isDark ? tWhite : tBlack,
              size: 22,
            ),
            onPressed: () {
              if (!mounted || currentPage >= totalPages) return;
              setState(() => currentPage++);
              fetchAlerts();
            },
          ),

          const SizedBox(width: 16),

          /// Page Input Box
          SizedBox(
            width: 70,
            height: 32,
            child: TextField(
              controller: controller,
              style: GoogleFonts.urbanist(
                fontSize: 13,
                color: isDark ? tWhite : tBlack,
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Page',
                hintStyle: GoogleFonts.urbanist(
                  fontSize: 12,
                  color: isDark ? Colors.white54 : Colors.black54,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDark ? tWhite : tBlack,
                    width: 0.8,
                  ),
                ),
              ),
              onSubmitted: (value) {
                final page = int.tryParse(value);
                if (page != null &&
                    page >= 1 &&
                    page <= totalPages &&
                    mounted) {
                  setState(() => currentPage = page);
                  fetchAlerts();
                }
              },
            ),
          ),

          const SizedBox(width: 10),

          /// Show visible range (e.g., "1–5 of 20")
          Text(
            '$startPage–$endPage of $totalPages',
            style: GoogleFonts.urbanist(
              fontSize: 13,
              color: isDark ? tWhite : tBlack,
            ),
          ),
        ],
      ),
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
                    'Loading alerts...',
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
