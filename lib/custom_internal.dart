import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

changeBrightness(context) {
  DynamicTheme.of(context).setBrightness(
      Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark);
}

Widget customBackAppbar (context) {
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