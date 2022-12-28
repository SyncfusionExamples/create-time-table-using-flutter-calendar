import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(const TimeTableCalendar());

class TimeTableCalendar extends StatefulWidget {
  const TimeTableCalendar({super.key});

  @override
  CalendarAppointment createState() => CalendarAppointment();
}

class CalendarAppointment extends State<TimeTableCalendar> {
  final CalendarDataSource _dataSource = _DataSource(<Appointment>[]);
  final List<String> _subjectCollection = <String>[];
  final List<DateTime> _startTimeCollection = <DateTime>[];
  final List<DateTime> _endTimeCollection = <DateTime>[];
  final List<Color> _colorCollection = <Color>[];
  List<TimeRegion> _specialTimeRegion = <TimeRegion>[];

  @override
  void initState() {
    _getSubjectCollection();
    _getStartTimeCollection();
    _getEndTimeCollection();
    _getColorCollection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SfCalendar(
            dataSource: _dataSource,
            view: CalendarView.week,
            allowedViews: const [
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
            onViewChanged: viewChanged,
            specialRegions: _specialTimeRegion,
          ),
        ),
      ),
    );
  }

  void viewChanged(ViewChangedDetails viewChangedDetails) {
    List<DateTime> visibleDates = viewChangedDetails.visibleDates;
    List<TimeRegion> timeRegion = <TimeRegion>[];
    List<Appointment> appointments = <Appointment>[];
    _dataSource.appointments!.clear();

    for (int i = 0; i < visibleDates.length; i++) {
      if (visibleDates[i].weekday == 6 || visibleDates[i].weekday == 7) {
        continue;
      }
      timeRegion.add(TimeRegion(
          startTime: DateTime(visibleDates[i].year, visibleDates[i].month,
              visibleDates[i].day, 13, 0, 0),
          endTime: DateTime(visibleDates[i].year, visibleDates[i].month,
              visibleDates[i].day, 14, 0, 0),
          text: 'Break',
          enablePointerInteraction: false));
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _specialTimeRegion = timeRegion;
        });
      });
      for (int j = 0; j < _startTimeCollection.length; j++) {
        DateTime startTime = DateTime(
            visibleDates[i].year,
            visibleDates[i].month,
            visibleDates[i].day,
            _startTimeCollection[j].hour,
            _startTimeCollection[j].minute,
            _startTimeCollection[j].second);
        DateTime endTime = DateTime(
            visibleDates[i].year,
            visibleDates[i].month,
            visibleDates[i].day,
            _endTimeCollection[j].hour,
            _endTimeCollection[j].minute,
            _endTimeCollection[j].second);
        Random random = Random();
        appointments.add(Appointment(
            startTime: startTime,
            endTime: endTime,
            subject: _subjectCollection[random.nextInt(9)],
            color: _colorCollection[random.nextInt(9)]));
      }
    }
    for (int i = 0; i < appointments.length; i++) {
      _dataSource.appointments!.add(appointments[i]);
    }
    _dataSource.notifyListeners(
        CalendarDataSourceAction.reset, _dataSource.appointments!);
  }

  void _getSubjectCollection() {
    _subjectCollection.add('General Meeting');
    _subjectCollection.add('Plan Execution');
    _subjectCollection.add('Project Plan');
    _subjectCollection.add('Consulting');
    _subjectCollection.add('Support');
    _subjectCollection.add('Development Meeting');
    _subjectCollection.add('Scrum');
    _subjectCollection.add('Project Completion');
    _subjectCollection.add('Release updates');
    _subjectCollection.add('Performance Check');
  }

  void _getStartTimeCollection() {
    var currentDateTime = DateTime.now();

    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 9, 0, 0));
    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 10, 0, 0));
    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 11, 0, 0));
    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 12, 0, 0));
    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 14, 0, 0));
    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 15, 0, 0));
    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 16, 0, 0));
    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 17, 0, 0));
    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 18, 0, 0));
  }

  void _getEndTimeCollection() {
    var currentDateTime = DateTime.now();
    _endTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 10, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 11, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 12, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 13, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 15, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 16, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 17, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 18, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 19, 0, 0));
  }

  void _getColorCollection() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}