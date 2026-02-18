import 'package:flutter/material.dart';

enum ThemeColor {
  blue(color: Color.fromARGB(255, 34, 118, 229)),
  pink(color: Color.fromARGB(255, 229, 158, 221)),
  green(color: Color.fromARGB(255, 156, 202, 8));

  const ThemeColor({required this.color});

  final Color color;
  Color get backgroundColor => color.withAlpha(100);
}



class ThemeColorController extends ChangeNotifier {
  ThemeColor _currentThemeColor = ThemeColor.blue;

  ThemeColor get currentThemeColor => _currentThemeColor;

  set currentThemeColor(ThemeColor newThemeColor) {
    _currentThemeColor = newThemeColor;
    notifyListeners();
  }
}
