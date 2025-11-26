import 'package:flutter/material.dart';

class ActionLogProvider extends ChangeNotifier {
  List<String> actionLog = [];
  String filterDevice = 'All';

  // Device states
  bool isLightOn = false;
  bool isDoorOpen = false;
  double temperature = 10.0;
  int fanSpeed = 0;

  // Power usage data
  List<double> powerUsage = List.filled(100, 0.0);

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
    updatePowerUsage(); // Add this line
    notifyListeners();
  }

  void toggleDoor() {
    isDoorOpen = !isDoorOpen;
    addLog('Front Door ${isDoorOpen ? 'UNLOCKED' : 'LOCKED'}');
    updatePowerUsage(); // Add this line
    notifyListeners();
  }

  void setTemperature(double value) {
    temperature = value;
    addLog('Thermostat set to ${temperature.toStringAsFixed(1)}°C');
    updatePowerUsage(); // Add this line
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
    updatePowerUsage(); // Add this line
    notifyListeners();
  }

  void updatePowerUsage() {
    // Calculate power based on devices
    double power = 0.0;

    if (isLightOn) power += 0.5;
    if (isDoorOpen) power += 0.2;
    if (fanSpeed > 0) power += (fanSpeed * 0.3);
    power += (temperature / 10.0);

    // Add to weekly data
    powerUsage.removeAt(0);
    powerUsage.add(power);
    notifyListeners();
  }

  void updatePowerUsageRealTime() {
    // Calculate current power
    double power = 0.0;

    if (isLightOn) power += 0.5;
    if (isDoorOpen) power += 0.2;
    if (fanSpeed > 0) power += (fanSpeed * 0.3);
    power += (temperature / 10.0);

    // Add small variation for realistic simulation
    power += (DateTime.now().microsecond % 100) / 500.0;

    // Update array
    powerUsage.removeAt(0);
    powerUsage.add(power);
    notifyListeners();
  }
}
