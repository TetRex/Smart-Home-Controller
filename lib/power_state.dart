import 'package:flutter/material.dart';

class PowerState extends ChangeNotifier {
  List<double> powerUsage = [3, 1, 4, 2, 5, 3, 4];

  void addPowerReading(double value) {
    powerUsage.add(value);
    if (powerUsage.length > 7) {
      powerUsage.removeAt(0);
    }
    notifyListeners();
  }

  void updateCurrentUsage(double value) {
    if (powerUsage.isNotEmpty) {
      powerUsage[powerUsage.length - 1] = value;
    } else {
      powerUsage.add(value);
    }
    notifyListeners();
  }
}
