import 'package:flutter/material.dart';

class Settings with ChangeNotifier {
  Color primary = const Color.fromARGB(255, 0, 190, 184);
  Color color1 = const Color.fromARGB(255, 0, 190, 184);

  Color get getPrimary {
    return primary;
  }

  Color get getColor1 {
    return color1;
  }
}
