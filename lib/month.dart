import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(const LongPressDetails());

class LongPressDetails extends StatelessWidget {
  const LongPressDetails({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LongPressCalendar(),
    );
  }
}

class LongPressCalendar extends StatefulWidget {
  const LongPressCalendar({super.key});

  @override
  _LongPressCalendarState createState() => _LongPressCalendarState();
}

class _LongPressCalendarState extends State<LongPressCalendar> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SfCalendar(
            view: CalendarView.month,
            onTap: longPressed,
            allowedViews: const <CalendarView>[
              CalendarView.day,
              CalendarView.week,
              CalendarView.workWeek,
              CalendarView.month,
              CalendarView.timelineDay,
              CalendarView.timelineWeek,
              CalendarView.timelineWorkWeek,
              CalendarView.timelineMonth,
              CalendarView.schedule
            ],
          ),
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void longPressed(CalendarTapDetails calendarLongPressDetails) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.90 ,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: const Center(
          child: Text("Modal content goes here"),
        ),
      ),
    ).whenComplete(() {

    });
  }
}