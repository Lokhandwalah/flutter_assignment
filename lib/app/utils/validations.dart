import 'package:flutter/foundation.dart';

typedef ValidatorFunction<T> = T Function(T value);

abstract class FieldValidator<T> {
  final String errorText;
  FieldValidator(this.errorText) : assert(errorText != null);
  bool isValid(T value);
  String call(T value) => isValid(value) ? null : errorText;
}

abstract class TextFieldValidator extends FieldValidator<String> {
  TextFieldValidator(String errorText) : super(errorText);
  bool get ignoreEmptyValues => true;

  @override
  String call(String value) =>
      (ignoreEmptyValues && value.isEmpty) ? null : super.call(value);

  bool hasMatch(String pattern, String input, {bool caseSensitive: true}) =>
      RegExp(pattern, caseSensitive: caseSensitive).hasMatch(input);
}

class RequiredValidator extends TextFieldValidator {
  RequiredValidator({@required String errorText}) : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String value) => value.trim().isNotEmpty;

  @override
  String call(String value) => isValid(value) ? null : errorText;
}

class DateValidator extends FieldValidator<DateTime> {
  DateValidator({@required String errorText}) : super(errorText);

  @override
  bool isValid(DateTime value) => value != null;

  @override
  String call(DateTime value) => isValid(value) ? null : errorText;
}

class MaxLengthValidator extends TextFieldValidator {
  final int max;

  MaxLengthValidator(this.max, {@required String errorText}) : super(errorText);

  @override
  bool isValid(String value) {
    return value.length <= max;
  }
}

class MinLengthValidator extends TextFieldValidator {
  final int min;

  MinLengthValidator(this.min, {@required String errorText}) : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String value) {
    return value.length >= min;
  }
}

class LengthRangeValidator extends TextFieldValidator {
  final int min;
  final int max;
  final int exact;

  @override
  bool get ignoreEmptyValues => false;

  LengthRangeValidator(
      {this.min, this.max, this.exact, @required String errorText})
      : assert((min != null && max != null) || exact != null),
        super(errorText);

  @override
  bool isValid(String value) {
    return exact != null
        ? value.length == exact
        : value.length >= min && value.length <= max;
  }
}

class WordCountValidator extends TextFieldValidator {
  final int count;

  WordCountValidator(this.count, {@required String errorText})
      : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String value) {
    return value.trim().split(' ').length == count;
  }
}

class EmailValidator extends TextFieldValidator {
  /// regex pattern to validate email inputs.
  Pattern _emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  EmailValidator({@required String errorText}) : super(errorText);

  @override
  bool isValid(String value) =>
      hasMatch(_emailPattern, value, caseSensitive: false);
}

class PatternValidator extends TextFieldValidator {
  final Pattern pattern;
  final bool caseSensitive;

  PatternValidator(this.pattern,
      {@required String errorText, this.caseSensitive = true})
      : super(errorText);

  @override
  bool isValid(String value) =>
      hasMatch(pattern, value, caseSensitive: caseSensitive);
}

class MultiValidator extends FieldValidator {
  final List<FieldValidator> validators;
  static String _errorText = '';

  MultiValidator(this.validators) : super(_errorText);

  @override
  bool isValid(value) {
    for (FieldValidator validator in validators) {
      if (validator.call(value) != null) {
        _errorText = validator.errorText;
        return false;
      }
    }
    return true;
  }

  @override
  String call(dynamic value) {
    return isValid(value) ? null : _errorText;
  }
}
