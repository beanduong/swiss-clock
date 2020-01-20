import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swiss_clock/widgets/clock_specs.dart';

final int rows = 6;
final List<String> weekDayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

/// Calendar widget to display date and month information.
class DateInfo extends StatefulWidget {
  DateInfo({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DateInfoState();
  }
}

class DateInfoState extends State<DateInfo> {
  /// [Timer] for updating the current date.
  Timer _timer;

  /// Current [DateTime].
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Update current date in a given interval.
    _timer = Timer.periodic(Duration(seconds: 10), (v) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
          color: ClockSpecs.of(context).data.primaryColor,
          fontFamily: 'GothicA1 Regular'),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                bottom: ClockSpecs.of(context).data.height * 0.025),
            child: Text(
              DateFormat.MMMM("en_US").format(_now),
              style: TextStyle(
                  fontSize: ClockSpecs.of(context).data.height * 0.05),
            ),
          ),
          Table(
            children: _buildTableRows(),
          )
        ],
      ),
    );
  }

  /// Create a date cell for table rows.
  Widget _buildDateCell(
    String day,
    Color color,
    bool isSelected,
  ) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: ClockSpecs.of(context).data.height * 0.01),
        child: Container(
          decoration: isSelected
              ? BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: color)),
                )
              : null,
          child: Text(
            day.toString(),
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: ClockSpecs.of(context).data.height * 0.025,
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  /// Create the table rows for the calendar table.
  List<TableRow> _buildTableRows() {
    final int startDate = DateTime(_now.year, _now.month, 1).weekday - 2;
    final int dateCount = rows * DateTime.daysPerWeek;

    // Create a Queue with all date cells that should be on the calendar for the given month.
    Queue<Widget> days = Queue<Widget>();
    for (int i = -startDate, j = 0; i < dateCount - startDate; i++, j++) {
      if (i <= getDayOfNextMonth(_now, 0)) {
        int day = DateTime(_now.year, _now.month, i).day;
        days.add(
          _buildDateCell(
            day.toString(),
            i >= 1
                ? ClockSpecs.of(context).data.primaryColor
                : ClockSpecs.of(context).data.primaryColor.withAlpha(80),
            day == _now.day,
          ),
        );
      } else {
        int day = getDayOfNextMonth(_now, i - getDayOfNextMonth(_now, 0));
        days.add(
          _buildDateCell(
            day.toString(),
            ClockSpecs.of(context).data.primaryColor.withAlpha(80),
            false,
          ),
        );
      }
    }

    // Create the table with the date cells.
    List<TableRow> tableRows = List.generate(
      rows,
      (row) => TableRow(
        children: List.generate(DateTime.daysPerWeek, (i) {
          return days.removeFirst();
        }),
      ),
    );

    // Insert table header for the weekdays.
    tableRows.insert(
      0,
      TableRow(
        children: List.generate(
          weekDayLabels.length,
          (i) => _buildDateCell(
            weekDayLabels[i],
            ClockSpecs.of(context).data.primaryColor,
            false,
          ),
        ),
      ),
    );
    return tableRows;
  }

  /// Get day of next month with the given index.
  int getDayOfNextMonth(DateTime date, int offset) {
    return (date.month < DateTime.monthsPerYear)
        ? DateTime(date.year, date.month + 1, offset).day
        : DateTime(date.year + 1, 1, offset).day;
  }

  /// Get day of last month with the given index.
  int getDayOfPreviousMonth(DateTime date, int offset) {
    return DateTime(date.year, date.month, -offset).day;
  }
}
