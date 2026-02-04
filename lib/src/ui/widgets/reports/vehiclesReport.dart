import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../provider/fleetModeProvider.dart';
import '../../../utils/appColors.dart';

class VehiclesReportView extends StatefulWidget {
  final String title;
  final String description;
  const VehiclesReportView({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<VehiclesReportView> createState() => _VehiclesReportViewState();
}

class _VehiclesReportViewState extends State<VehiclesReportView> {
  DateTime? fromDate;
  DateTime? toDate;

  String availability = 'All';
  String vehicleStatus = 'All';

  final TextEditingController searchController = TextEditingController();

  final List<String> availabilityOptions = ['All', 'Active', 'Inactive'];

  final List<String> _nonEVStatuses = [
    'Moving',
    'Stopped',
    'Idle',
    'Disconnected',
    'Non Coverage',
  ];
  final List<String> _evStatuses = [
    'Charging',
    'DisCharging',
    'Idle',
    'Disconnected',
  ];

  final Map<String, Color> _nonEVStatusColors = {
    'Moving': tGreen,
    'Stopped': tRed,
    'Idle': tOrange1,
    'Disconnected': tGrey,
    'Non Coverage': const Color(0xFF9C27B0),
  };

  final Map<String, Color> _evStatusColors = {
    'DisCharging': tGreen,
    'Charging': const Color(0xFF009688),
    'Idle': tOrange1,
    'Disconnected': tGrey,
  };

  Color _statusColor(String status, bool isEVFleet) {
    final map = isEVFleet ? _evStatusColors : _nonEVStatusColors;
    return map[status] ?? tBlue;
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    fromDate = now;
    toDate = now;
  }

  String _formatDate(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return "${date.day.toString().padLeft(2, '0')} "
        "${months[date.month - 1]} "
        "${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mode = context.watch<FleetModeProvider>().mode;
    final bool isEVFleet = mode == 'EV Fleet';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.urbanist(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? tWhite : tBlack,
                  ),
                ),
                const SizedBox(height: 5),

                Text(
                  widget.description,
                  style: GoogleFonts.urbanist(
                    fontSize: 13,
                    color: (isDark ? tWhite : tBlack).withOpacity(0.8),
                  ),
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: tBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              child: Text(
                'Generate Report',
                style: GoogleFonts.urbanist(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: tWhite,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 5),
        Divider(
          color: isDark ? tWhite.withOpacity(0.6) : tBlack.withOpacity(0.6),
          height: 1,
        ),
        const SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                /// FROM DATE
                Row(
                  children: [
                    _dateLabelBox('From Date', isDark),
                    const SizedBox(width: 5),
                    _dateValueBox(
                      _formatDate(fromDate!),
                      isDark,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: fromDate!,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() => fromDate = picked);
                        }
                      },
                    ),
                  ],
                ),

                const SizedBox(width: 30),

                /// TO DATE
                Row(
                  children: [
                    _dateLabelBox('To Date', isDark),
                    const SizedBox(width: 5),
                    _dateValueBox(
                      _formatDate(toDate!),
                      isDark,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: toDate!,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() => toDate = picked);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),
            _chipSection(
              title: "Filter by Availability",
              options: availabilityOptions,
              selected: availability,
              onSelected: (val) => setState(() => availability = val),
              isDark: isDark,
            ),

            const SizedBox(height: 10),
            _chipSection(
              title: "Filter by Vehicle Status",
              options: isEVFleet ? _evStatuses : _nonEVStatuses,
              selected: vehicleStatus,
              onSelected: (val) => setState(() => vehicleStatus = val),
              isDark: isDark,
              isEVFleet: isEVFleet,
            ),

            const SizedBox(height: 15),
            Text(
              'Search by Vehicle ID or IMEI',
              style: GoogleFonts.urbanist(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? tWhite : tBlack,
              ),
            ),
            SizedBox(height: 10),
            _searchField(isDark),
          ],
        ),
      ],
    );
  }

  Widget _dateLabelBox(String text, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: tTransparent,
        border: Border.all(color: isDark ? tWhite : tBlack, width: 1),
      ),
      child: Text(
        text,
        style: GoogleFonts.urbanist(
          fontSize: 13,
          color: tBlue,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _dateValueBox(
    String value,
    bool isDark, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: tTransparent,
          border: Border.all(color: isDark ? tWhite : tBlack, width: 1),
        ),
        child: Text(
          value,
          style: GoogleFonts.urbanist(
            fontSize: 13,
            color: isDark ? tWhite : tBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _chipSection({
    required String title,
    required List<String> options,
    required String selected,
    required Function(String) onSelected,
    required bool isDark,
    bool? isEVFleet,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.urbanist(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? tWhite : tBlack,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children:
              options.map((option) {
                final isSelected = selected == option;

                return ChoiceChip(
                  showCheckmark: true,
                  checkmarkColor: isDark ? tBlack : tWhite,
                  label: Text(
                    option,
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,

                      color: isSelected ? tWhite : (isDark ? tWhite : tBlack),
                    ),
                  ),
                  selected: isSelected,
                  selectedColor:
                      isEVFleet == null
                          ? tBlue // Availability / generic chips
                          : _statusColor(option, isEVFleet),
                  backgroundColor:
                      isDark
                          ? tWhite.withOpacity(0.15)
                          : tBlack.withOpacity(0.1),
                  side: BorderSide(color: Colors.transparent, width: 0),
                  onSelected: (_) => onSelected(option),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _searchField(bool isDark) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Enter Vehicle ID or IMEI",
        hintStyle: GoogleFonts.urbanist(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isDark ? tWhite.withOpacity(0.6) : tBlack.withOpacity(0.6),
        ),
        prefixIcon: Icon(
          Icons.search_outlined,
          size: 18,
          color: isDark ? tWhite : tBlack,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
      ),
    );
  }
}
