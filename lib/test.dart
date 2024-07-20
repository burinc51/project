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
  final List<Appointment> _appointmentDetails = <Appointment>[];
  late _DataSource dataSource;
  final CalendarController _controller = CalendarController();
  String? _headerText;
  double? width, cellWidth;
  bool monthChk = false;
  @override
  void initState() {
    _headerText = 'month';
    width = 0.0;
    cellWidth = 0.0;
    super.initState();
    dataSource = getCalendarDataSource();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    cellWidth = ((width! - 58) / 7);
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
                            fontFamily: 'Sora',
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
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
                  cellEndPadding: 0,
                  todayHighlightColor: Colors.red,
                  onTap: selectionTap,
                  selectionDecoration: const BoxDecoration(
                    color: Colors.black12,
                  ),
                  dataSource: dataSource,
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
    getSelectedDateAppointments(details.date);
  }

  void getSelectedDateAppointments(DateTime? selectedDate) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        _appointmentDetails.clear();
      });

      if (dataSource.appointments!.isEmpty) {
        return;
      }

      for (int i = 0; i < dataSource.appointments!.length; i++) {
        Appointment appointment = dataSource.appointments![i] as Appointment;

        final Appointment? occurrenceAppointment = dataSource.getOccurrenceAppointment(appointment, selectedDate!, '');
        if ((DateTime(appointment.startTime.year, appointment.startTime.month,
                    appointment.startTime.day) ==
                DateTime(
                    selectedDate.year, selectedDate.month, selectedDate.day)) ||
            occurrenceAppointment != null) {
          setState(() {
            _appointmentDetails.add(appointment);
          });
        }
      }

      if (dataSource.appointments!.isNotEmpty) {
        print(width);
        String _DateAndMounth = DateFormat('dd MMMM yyyy').format(selectedDate!).toString();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.95,
            width: width,
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
                    // Text(_DateAndMounth)
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        child: Text(
                          _DateAndMounth,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: ListView.separated(
                        itemCount: _appointmentDetails.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              padding: const EdgeInsets.all(2),
                              height: 60,
                              color: _appointmentDetails[index].color,
                              child: ListTile(
                                leading: Column(
                                  children: <Widget>[
                                    Text(
                                      _appointmentDetails[index].isAllDay
                                          ? ''
                                          : DateFormat('hh:mm a').format(
                                          _appointmentDetails[index].startTime),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          height: 1.5),
                                    ),
                                    Text(
                                      _appointmentDetails[index].isAllDay
                                          ? 'All day'
                                          : '',
                                      style: const TextStyle(
                                          height: 0.5, color: Colors.white),
                                    ),
                                    Text(
                                      _appointmentDetails[index].isAllDay
                                          ? ''
                                          : DateFormat('hh:mm a').format(
                                          _appointmentDetails[index].endTime),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  getIcon(_appointmentDetails[index].subject),
                                  size: 30,
                                  color: Colors.white,
                                ),
                                title: Text(
                                    _appointmentDetails[index].subject,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                          height: 5,
                        )
                    ))
                // LayoutBuilder(builder: (BuildContext context,)),
              ],
            ),
          ),
        ).whenComplete(() {});
      }

    });
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



  _DataSource getCalendarDataSource() {
    final List<Appointment> appointments = <Appointment>[];

    appointments.add(Appointment(
        startTime: DateTime.now().add(const Duration(days: -1)),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        subject: 'Recurrence',
        color: Colors.red,
        recurrenceRule: 'FREQ=DAILY;INTERVAL=2;COUNT=10'
    ));

    appointments.add(Appointment(
        startTime: DateTime.now().add(const Duration(hours: 4, days: -1)),
        endTime: DateTime.now().add(const Duration(hours: 5, days: -1)),
        subject: 'Release Meeting',
        color: Colors.lightBlueAccent,
        isAllDay: true));

    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Meeting',
      color: const Color(0xFFfb21f66),
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: -2, hours: 4)),
      endTime: DateTime.now().add(const Duration(days: -2, hours: 5)),
      subject: 'Development Meeting   New York, U.S.A',
      color: const Color(0xFFf527318),
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: -2, hours: 3)),
      endTime: DateTime.now().add(const Duration(days: -2, hours: 4)),
      subject: 'Project Plan Meeting   Kuala Lumpur, Malaysia',
      color: const Color(0xFFfb21f66),
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: -2, hours: 2)),
      endTime: DateTime.now().add(const Duration(days: -2, hours: 3)),
      subject: 'Support - Web Meeting   Dubai, UAE',
      color: const Color(0xFFf3282b8),
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: -2, hours: 1)),
      endTime: DateTime.now().add(const Duration(days: -2, hours: 2)),
      subject: 'Project Release Meeting   Istanbul, Turkey',
      color: const Color(0xFFf2a7886),
    ));

    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 2, days: -4)),
      endTime: DateTime.now().add(const Duration(hours: 4, days: -4)),
      subject: 'Performance check',
      color: Colors.amber,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 11, days: -2)),
      endTime: DateTime.now().add(const Duration(hours: 12, days: -2)),
      subject: 'Customer Meeting   Tokyo, Japan',
      color: const Color(0xFFffb8d62),
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 6, days: 2)),
      endTime: DateTime.now().add(const Duration(hours: 7, days: 2)),
      subject: 'Retrospective',
      color: Colors.purple,
    ));

    return _DataSource(appointments);
  }

  IconData getIcon(String subject) {
    if (subject == 'Planning') {
      return Icons.subject;
    } else if (subject == 'Development Meeting   New York, U.S.A') {
      return Icons.people;
    } else if (subject == 'Support - Web Meeting   Dubai, UAE') {
      return Icons.settings;
    } else if (subject == 'Project Plan Meeting   Kuala Lumpur, Malaysia') {
      return Icons.check_circle_outline;
    } else if (subject == 'Retrospective') {
      return Icons.people_outline;
    } else if (subject == 'Project Release Meeting   Istanbul, Turkey') {
      return Icons.people_outline;
    } else if (subject == 'Customer Meeting   Tokyo, Japan') {
      return Icons.settings_phone;
    } else if (subject == 'Release Meeting') {
      return Icons.view_day;
    } else {
      return Icons.beach_access;
    }
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}

