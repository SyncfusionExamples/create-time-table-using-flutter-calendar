# How to create time table using Flutter Event Calendar

This example demonstrates how to create time table using Flutter Event Calendar.

## Creating time table

You can create time table by adding appointments for particular days of week by using [onViewChanged](https://help.syncfusion.com/flutter/calendar/callbacks#view-changed-callback) callback in Flutter Calendar.

Using the onViewchanged callback you can checks whether the visible date weekday is not fallen on the weekend to add appointments for weekdays.

```
void viewChanged(ViewChangedDetails viewChangedDetails) {
  List<DateTime> visibleDates = viewChangedDetails.visibleDates;
  List<TimeRegion> _timeRegion = <TimeRegion>[];
  List<Appointment> appointments = <Appointment>[];
  _dataSource.appointments!.clear();
 
  for (int i = 0; i < visibleDates.length; i++) {
    if (visibleDates[i].weekday == 6 || visibleDates[i].weekday == 7) {
      continue;
    }
    _timeRegion.add(TimeRegion(
        startTime: DateTime(visibleDates[i].year, visibleDates[i].month,
            visibleDates[i].day, 13, 0, 0),
        endTime: DateTime(visibleDates[i].year, visibleDates[i].month,
            visibleDates[i].day, 14, 0, 0),
        text: 'Break',
        enablePointerInteraction: false));
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        _specialTimeRegion = _timeRegion;
      });
    });
    for (int j = 0; j < _startTimeCollection.length; j++) {
      DateTime startTime = new DateTime(
          visibleDates[i].year,
          visibleDates[i].month,
          visibleDates[i].day,
          _startTimeCollection[j].hour,
          _startTimeCollection[j].minute,
          _startTimeCollection[j].second);
      DateTime endTime = new DateTime(
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

```

![Timetable](https://user-images.githubusercontent.com/46158936/203065284-d922b7cb-9772-431d-a1cf-95480f179d5e.gif)

## Requirements to run the demo
* [VS Code](https://code.visualstudio.com/download)
* [Flutter SDK v1.22+](https://flutter.dev/docs/development/tools/sdk/overview)
* [For more development tools](https://flutter.dev/docs/development/tools/devtools/overview)

## How to run this application
To run this application, you need to first clone or download the ‘create a flutter maps widget in 10 minutes’ repository and open it in your preferred IDE. Then, build and run your project to view the output.

## Further help
For more help, check the [Syncfusion Flutter documentation](https://help.syncfusion.com/flutter/introduction/overview),
 [Flutter documentation](https://flutter.dev/docs/get-started/install).
