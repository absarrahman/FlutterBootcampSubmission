import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

bool isDark;

checkTheme(context) {
  isDark = Theme.of(context).brightness == Brightness.dark ? true : false;
}

changeBrightness(context) {
  DynamicTheme.of(context).setBrightness(
      Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark);
}

Widget loading() {
  return Scaffold(
    body: Container(
      child: SpinKitRing(color: Colors.orange),
    ),
  );
}

Widget customBackAppbar(context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    ),
  );
}

String validateEmail(String value) {
  if (value.contains("@")) {
    return null;
  }
  return "Invalid email";
}

String validatePassword(String value) {
  if (value.length >= 8) {
    return null;
  }
  return "Password length should be at least\n 8 characters";
}

String validateOtherFields(String value) {
  if (value.length == 0) {
    return "You cannot keep this field blank";
  }
  return null;
}
