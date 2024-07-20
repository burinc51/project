import 'package:flutter/material.dart';
import 'package:project/daycell.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final CalendarController _controller = CalendarController();
  String? _headerText;
  double? width, cellWidth;
  bool monthChk = false;
  String _text = "";
  @override
  void initState() {
    _headerText = 'month';
    width = 0.0;
    cellWidth = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width ;
    cellWidth = ((width!-58) / 7);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 223, 223, 223),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: 150,
                  height: 40,
                  child: Center(
                    child: Text(_headerText!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily:'Sora' ,
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        )),
                  ),
                ),
              ),
              DayCellWidget(
                width: cellWidth,
              ),
              Expanded(
                child: SfCalendar(
                  controller: _controller,
                  headerHeight: 0,
                  viewHeaderHeight: 0,
                  view: CalendarView.month,
                  backgroundColor: Colors.white,
                  monthCellBuilder: monthCellBuilder,
                  // timeRegionBuilder: timeregionBuilder,
                  // specialRegions: _getTimeRegions(),
                  cellEndPadding: 0,
                  todayHighlightColor: Colors.red,
                  onTap: selectionTap,
                  selectionDecoration: const BoxDecoration(
                    color: Colors.black12,
                  ),
                  dataSource: MeetingDataSource(_getDataSource()),
                  monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment,
                    dayFormat: 'EEE',
                  ),
                  onViewChanged: (ViewChangedDetails viewChangedDetails) {
                    _headerText = DateFormat('MMMM yyyy')
                        .format(viewChangedDetails.visibleDates[
                            viewChangedDetails.visibleDates.length ~/ 2])
                        .toString();
                    SchedulerBinding.instance.addPostFrameCallback((duration) {
                      setState(() {});
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
    );
  }

  void selectionTap(CalendarTapDetails details) {
    _text = DateFormat('dd MMMM yyyy').format(details.date!).toString();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.95,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black45,
                    height: 2,
                    width: MediaQuery.of(context).size.width / 5,
                  ),
                )
                // Text(_text)
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    child: Text(_text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
              ],
            ),
            // LayoutBuilder(builder: (BuildContext context,)),
          ],
        ),
      ),
    ).whenComplete(() {});
  }

  Widget monthCellBuilder(BuildContext context, MonthCellDetails details) {
    if (details.date.day == 1 && !monthChk) {
      monthChk = true;
    } else if (details.date.day == 1 && monthChk) {
      monthChk = false;
    }

    if (details.date.day == DateTime.now().day &&
        details.date.month == DateTime.now().month) {
      return Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 3),
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(color: Colors.black12, width: 1),
        )),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: Colors.black,
                width: 5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              details.date.day.toString(),
              style: const TextStyle(color: Colors.white),
            )),
      );
    }
    if (monthChk) {
      return Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 7.5),
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(color: Colors.black12, width: 1),
        )),
        child: Text(
          details.date.day.toString(),
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 7.5),
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(color: Colors.black12, width: 1),
        )),
        child: Text(
          details.date.day.toString(),
          style: const TextStyle(fontSize: 16, color: Colors.black45),
        ),
      );
    }
  }

  // Widget timeregionBuilder(
  //     BuildContext context, TimeRegionDetails timeRegionDetails) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //         color: Colors.green,
  //         width: 2,
  //       ),
  //       borderRadius: BorderRadius.circular(1),
  //     ),
  //   );
  // }

  // List<TimeRegion> _getTimeRegions() {
  //   final List<TimeRegion> regions = <TimeRegion>[];
  //   DateTime date = DateTime.now();
  //   date = DateTime(date.year, date.month, date.day, 12, 0, 0);
  //   regions.add(TimeRegion(
  //       startTime: date,
  //       endTime: date.add(const Duration(hours: 2)),
  //       enablePointerInteraction: false,
  //       color: Colors.grey.withOpacity(0.2),
  //       text: 'Break',
  //       iconData: Icons.free_breakfast));
  //   regions.add(TimeRegion(
  //       startTime: date.add(Duration(hours: 5)),
  //       endTime: date.add(const Duration(hours: 6)),
  //       enablePointerInteraction: false,
  //       color: Colors.grey.withOpacity(0.2),
  //       text: 'Break',
  //       iconData: Icons.free_breakfast));
  //   return regions;
  // }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 6));
    final DateTime endTime_1 = startTime.add(const Duration(days: 24));
    // meetings.add(Meeting(
    //     'Conference AAAAAAAAAAAAAAAAA', startTime, endTime,
    //     const Color(0xFF0F8644), false));
    // meetings.add(Meeting(
    //     'Conference BBBBBBBBBBBBBBBBB', startTime, endTime_1,
    //     const Color.fromARGB(255, 97, 130, 100), false));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
