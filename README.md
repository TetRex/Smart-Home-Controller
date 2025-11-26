# Smart Home Controller

<!-- filepath: /Users/tetrex/Documents/smart_home_controller/README.md -->

A modern Flutter desktop application for controlling and monitoring smart home devices in real-time.

## 🏠 Features

### Device Control
- **Living Room Light** - Toggle on/off with instant status feedback
- **Front Door** - Lock/unlock functionality
- **Thermostat** - Adjust temperature from 10°C to 30°C
- **Ceiling Fan** - Control speed (OFF, LOW, MEDIUM, HIGH)

### 📊 Real-Time Analytics
- **Live Power Consumption Chart** - Updates every second
- **Weekly Power Tracking** - 7-day consumption history
- **Current Power Display** - Real-time kW monitoring
- **Average Power Calculation** - Weekly statistics

### 📹 Camera Integration
- **Live Camera Feed** - MJPEG stream support
- **Real-time Video Monitoring** - IP camera streaming

### 📋 Action Logging
- **Complete History** - Timestamped device actions (HH:MM:SS)
- **Device Filtering** - Filter by Light, Door, Thermostat, Fan
- **Per-Device Details** - Individual device action history
- **Last 50 Actions** - Automatic history management

## 📁 Project Structure

```
smart_home_controller/
├── lib/
│   ├── main.dart                  # Home page & device control
│   ├── appbar.dart                # Navigation bar
│   ├── statistics.dart            # Analytics dashboard
│   ├── details.dart               # Device details page
│   ├── camera_player.dart         # Live camera feed
│   ├── action_log_provider.dart   # State management
│   └── power_state.dart           # (Legacy)
├── pubspec.yaml                   # Dependencies
└── README.md                      # Documentation
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.9.2 or higher
- macOS, Linux, or Windows

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd smart_home_controller
```

2. **Get dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
# macOS
flutter run -d macos

# Linux
flutter run -d linux

# Windows
flutter run -d windows
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.3.2
  window_manager: ^0.3.9
  video_player: ^2.8.0
  mjpeg_stream: ^1.0.0
  fl_chart: ^1.1.1
  provider: ^6.0.0
```

## 💡 Usage Guide

### Overview (Home) Page
1. **Control Devices**
   - Click "Turn ON/OFF" to toggle the light
   - Click "Lock/Unlock" to control the door
   - Drag sliders to adjust temperature and fan speed

2. **Monitor Power**
   - View real-time power consumption in kW
   - Watch the live graph update as devices change

3. **Watch Cameras**
   - Live MJPEG stream display
   - Real-time video monitoring

### Statistics Page
1. **Analyze Power Usage**
   - Real-time power consumption chart
   - Current power display
   - Weekly average calculation

2. **Filter Action Log**
   - Click filter buttons: All, Light, Door, Thermostat, Fan
   - See filtered device actions
   - View timestamps for each action

### Details Page
1. **Access Device Details**
   - Click "Details" button on any device card
   - View device-specific action history
   - Monitor individual device changes

## ⚡ Power Calculation

```
Total Power (kW) = Light (0.5) + Door (0.2) + Fan (Speed × 0.3) + Thermostat (Temp ÷ 10)
```

**Examples:**
- Light ON + Fan LOW: 0.5 + 0.3 = 0.8 kW
- All devices ON: 0.5 + 0.2 + 0.9 + 2.0 = 3.6 kW

## 🔄 Real-Time Updates

- **Chart Refresh**: Every 1 second
- **Power Updates**: Instant when devices change
- **Action Logging**: Immediate timestamped entries
- **Auto-Sync**: Provider-based state management

## 📹 Camera Setup

### Using Public Test Camera
```dart
// In camera_player.dart
streamUrl: 'http://204.106.237.68:88/mjpg/1/video.mjpg'
```

### Using Local IP Camera
```dart
streamUrl: 'http://192.168.1.100:8080/mjpg/video.mjpg'
```

### Public Test URLs
- `http://204.106.237.68:88/mjpg/1/video.mjpg`
- `http://162.142.195.32:8081/?action=stream`
- `http://218.100.68.36:8080/mjpg/video.mjpg`

## 🔧 Architecture

### State Management
Uses **Provider** pattern for centralized state:

```dart
ActionLogProvider manages:
- Device states (light, door, temperature, fan)
- Power usage history
- Action log with timestamps
- Filter preferences
```

### Widget Structure
- `MainApp` - Root widget with Provider
- `BarApp` - Navigation bar across all pages
- `Statistics` - Analytics & filtering
- `Details` - Device-specific details
- `CameraPlayer` - Live camera widget

## 🐛 Troubleshooting

### Camera Not Displaying
- Verify URL works in web browser
- Check MJPEG format support
- Ensure network connectivity

### Power Chart Not Updating
- Verify Timer is running (1-second interval)
- Check device state changes trigger updates
- Confirm Provider is properly initialized

### Action Log Empty
- Perform device actions (toggle, adjust sliders)
- Set filter to "All"
- Check ActionLogProvider is created in main()

## 📋 Features Checklist

- ✅ Device control (Light, Door, Thermostat, Fan)
- ✅ Real-time power monitoring
- ✅ Live power consumption chart
- ✅ Action logging with timestamps
- ✅ Device filtering
- ✅ Device details page
- ✅ Camera feed integration
- ✅ Provider state management
- ⬜ Cloud synchronization (future)
- ⬜ Mobile app (future)
- ⬜ Voice control (future)
- ⬜ Automation/Scenes (future)

## 📱 Interface Overview

### Home Page
- Device control cards (Light, Door)
- Thermostat slider
- Ceiling fan speed slider
- Live power consumption chart
- Camera feed display

### Statistics Page
- Real-time power chart with "Live" indicator
- Current power reading
- Weekly average power
- Filterable action log
- Filter buttons: All, Light, Door, Thermostat, Fan

### Details Page
- Device name as title
- Device-specific action history
- Back to overview button

## 🎨 Design Features

- **Modern UI** - Google Fonts (Inter Tight)
- **Color Coded** - Status indicators (green/red)
- **Responsive** - Works on various screen sizes
- **Smooth Animations** - Zero transition duration for instant navigation
- **Real-time Updates** - Live chart and data refresh

## 📝 License

MIT License - Feel free to use this project for personal or commercial purposes.

## 👨‍💻 Author

Created with Flutter & Provider

## 🔗 Related Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [FL Chart](https://pub.dev/packages/fl_chart)
- [Smart Home Integration](https://www.home-assistant.io/)

---

**Version**: 0.1.0  
**Last Updated**: November 2025  
**Platform**: macOS, Linux, Windows
