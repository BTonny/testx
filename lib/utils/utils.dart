import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TestXUtils {
  static void hideKeyboard(BuildContext context) {
    // FocusScope.of(context).requestFocus(new FocusNode())
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static String formatDate(DateTime date) {
    // e.g Thursday, 27th November 2023
    return DateFormat('EEEE, d MMMM y').format(date);
  }

  static String formatTime(DateTime date) {
    // e.g 12:00 PM
    return DateFormat.jm().format(date);
  }

  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
