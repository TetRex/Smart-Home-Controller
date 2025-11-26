import 'package:flutter/material.dart';

class ActionLogProvider extends ChangeNotifier {
  List<String> actionLog = [];
  String filterDevice = 'All';

  // Device states
  bool isLightOn = false;
  bool isDoorOpen = false;
  double temperature = 10.0;
  int fanSpeed = 0;

  // Power usage data - используйте пустой список вместо List.filled
  List<double> powerUsage = [3, 1, 4, 2, 5, 3, 4, 2];

  void addLog(String action) {
    final now = DateTime.now();
    final timeString =
        '${now.hour}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    actionLog.insert(0, '[$timeString] $action');
    if (actionLog.length > 50) {
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
    updatePowerUsageRealTime();
    notifyListeners();
  }

  void toggleDoor() {
    isDoorOpen = !isDoorOpen;
    addLog('Front Door ${isDoorOpen ? 'UNLOCKED' : 'LOCKED'}');
    updatePowerUsageRealTime();
    notifyListeners();
  }

  void setTemperature(double value) {
    temperature = value;
    addLog('Thermostat set to ${temperature.toStringAsFixed(1)}°C');
    updatePowerUsageRealTime();
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
    updatePowerUsageRealTime();
    notifyListeners();
  }

  void updatePowerUsage() {
    double power = 0.0;

    if (isLightOn) power += 0.5;
    if (isDoorOpen) power += 0.2;
    if (fanSpeed > 0) power += (fanSpeed * 0.3);
    power += (temperature / 10.0);

    // Добавляем новое значение и удаляем старое если > 10
    if (powerUsage.length >= 10) {
      powerUsage.removeAt(0);
    }
    powerUsage.add(power);
    notifyListeners();
  }

  void updatePowerUsageRealTime() {
    double power = 0.0;

    if (isLightOn) power += 0.5;
    if (isDoorOpen) power += 0.2;
    if (fanSpeed > 0) power += (fanSpeed * 0.3);
    power += (temperature / 10.0);

    // БЕЗ вариации - стабильное значение
    // Удаляем старое значение, если список слишком большой
    if (powerUsage.length >= 10) {
      powerUsage.removeAt(0);
    }
    powerUsage.add(power);
    notifyListeners();
  }
}
