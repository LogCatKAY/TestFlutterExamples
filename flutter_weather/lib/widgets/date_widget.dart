import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatefulWidget {

  final bool addWeekday;

  DateWidget({this.addWeekday = false});

  @override
  State createState() => _DateWidgetState(addWeekday);
}

class _DateWidgetState extends State<DateWidget> {

  final bool addWeekday;

  _DateWidgetState(this.addWeekday);

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _getDate(addWeekday),
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  String _getDate(bool addWeekday) {
    var today = DateTime.now();
    String weekday = "";

    if(addWeekday) {
      weekday = DateFormat.EEEE().format(today);
      weekday = toBeginningOfSentenceCase(weekday) + " - ";
    }

    String monthAndDay = DateFormat.MMMMd().format(today);

    if(weekday.isNotEmpty)
      return weekday + monthAndDay;
    else
      return monthAndDay;
  }
}
