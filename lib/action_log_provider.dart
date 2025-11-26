import 'package:flutter/material.dart';

class ActionLogProvider extends ChangeNotifier {
  List<String> actionLog = [];
  String filterDevice = 'All';

  // Device states
  bool isLightOn = false;
  bool isDoorOpen = false;
  double temperature = 10.0;
  int fanSpeed = 0;

  void addLog(String action) {
    final now = DateTime.now();
    final timeString =
        '${now.hour}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    actionLog.insert(0, '[$timeString] $action');
    if (actionLog.length > 15) {
      actionLog.removeLast();
    }
    notifyListeners();
  }

  List<String> getFilteredLog([String? deviceType]) {
    String filterBy = deviceType ?? filterDevice;

    if (filterBy == 'All' || filterBy.isEmpty) {
      return actionLog;
    }

    return actionLog.where((log) {
      switch (filterBy) {
        case 'light':
          return log.contains('Light');
        case 'door':
          return log.contains('Door');
        case 'temperature':
          return log.contains('Thermostat');
        case 'fan':
          return log.contains('Fan');
        default:
          return true;
      }
    }).toList();
  }

  void setFilter(String device) {
    filterDevice = device;
    notifyListeners();
  }

  void toggleLight() {
    isLightOn = !isLightOn;
    addLog('Living Room Light turned ${isLightOn ? 'ON' : 'OFF'}');
    notifyListeners();
  }

  void toggleDoor() {
    isDoorOpen = !isDoorOpen;
    addLog('Front Door ${isDoorOpen ? 'UNLOCKED' : 'LOCKED'}');
    notifyListeners();
  }

  void setTemperature(double value) {
    temperature = value;
    addLog('Thermostat set to ${temperature.toStringAsFixed(1)}°C');
    notifyListeners();
  }

  void setFanSpeed(int value) {
    fanSpeed = value;
    String speedName = '';
    switch (fanSpeed) {
      case 0:
        speedName = 'OFF';
        break;
      case 1:
        speedName = 'LOW';
        break;
      case 2:
        speedName = 'MEDIUM';
        break;
      case 3:
        speedName = 'HIGH';
        break;
    }
    addLog('Ceiling Fan set to $speedName');
    notifyListeners();
  }
}
