import 'package:flutter/material.dart';

int _hexColorToInt(String code) {
  return int.parse(code.substring(1, 7), radix: 16) + 0xFF000000;
}

Color hexToColor(String code) {
  return new Color(_hexColorToInt(code));
}

MaterialColor hexToMaterialColor(String code) {
  int primary = _hexColorToInt(code);

  Map<int, Color> color = {
    50: Color(primary).withOpacity(.1),
    100: Color(primary).withOpacity(.2),
    200: Color(primary).withOpacity(.3),
    300: Color(primary).withOpacity(.4),
    400: Color(primary).withOpacity(.5),
    500: Color(primary).withOpacity(.6),
    600: Color(primary).withOpacity(.7),
    700: Color(primary).withOpacity(.8),
    800: Color(primary).withOpacity(.9),
    900: Color(primary).withOpacity(1),
  };

  return MaterialColor(primary, color);
}
