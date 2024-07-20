import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(const Builder());

class Builder extends StatelessWidget {
  const Builder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SafeArea(
              child: SfCalendar(
                allowedViews: const [
                  CalendarView.day,
                  CalendarView.week,
                  CalendarView.workWeek,
                  CalendarView.month
                ],
                view: CalendarView.month,
                monthCellBuilder: monthCellBuilder,
                timeRegionBuilder: timeregionBuilder,
                specialRegions: _getTimeRegions(),
                // dataSource: _getCalendarDataSource(),
              ),
            )));
  }

  Widget monthCellBuilder(BuildContext context, MonthCellDetails details) {
    if (details.date.day == DateTime.now().day) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(1),
        ),
        child: Text(details.date.day.toString()),
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(1),
      ),
      child: Text(details.date.day.toString()),
    );
  }

  Widget timeregionBuilder(
      BuildContext context, TimeRegionDetails timeRegionDetails) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }

  List<TimeRegion> _getTimeRegions() {
    final List<TimeRegion> regions = <TimeRegion>[];
    DateTime date = DateTime.now();
    date = DateTime(date.year, date.month, date.day, 12, 0, 0);
    regions.add(TimeRegion(
        startTime: date,
        endTime: date.add(const Duration(hours: 2)),
        enablePointerInteraction: false,
        color: Colors.grey.withOpacity(0.2),
        text: 'Break',
        iconData: Icons.free_breakfast));
    regions.add(TimeRegion(
        startTime: date.add(Duration(hours: 5)),
        endTime: date.add(const Duration(hours: 6)),
        enablePointerInteraction: false,
        color: Colors.grey.withOpacity(0.2),
        text: 'Break',
        iconData: Icons.free_breakfast));
    return regions;
  }
}
