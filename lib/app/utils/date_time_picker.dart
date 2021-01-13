import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';

class DateTimePicker {
  Future<DateTime> datePicker(BuildContext context, DateTime current) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1990),
        lastDate: DateTime.now(),
        initialDate: current ?? DateTime.now());
    return date;
  }

  Future<DateTime> timePicker(BuildContext context, DateTime current) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(current ?? DateTime.now()),
    );
    return DateTimeField.convert(time);
  }

  Future<DateTime> dateTimePicker(
      BuildContext context, DateTime current) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1990),
        lastDate: DateTime.now(),
        initialDate: current ?? DateTime.now());
    if (date == null) return current;
    final time = await showTimePicker(
      context: context,
      initialTime:
          current != null ? TimeOfDay.fromDateTime(current) : TimeOfDay.now(),
    );
    return DateTimeField.combine(date, time);
  }
}
