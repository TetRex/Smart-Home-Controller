import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_controller/action_log_provider.dart';
import 'package:smart_home_controller/appbar.dart';
import 'package:smart_home_controller/camera_player.dart';
import 'package:smart_home_controller/details.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(minimumSize: Size(800, 600));
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.focus();
  });

  runApp(
    ChangeNotifierProvider(
      create: (context) => ActionLogProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ActionLogProvider>(
      builder: (context, logProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: BarApp(
              currentPage: 'home',
              logProvider: logProvider, // Pass logProvider to BarApp
            ),
            body: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ON/OFF Devices',
                        style: GoogleFonts.interTight(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(70, 255, 235, 59),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 8, top: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.lightbulb,
                                        size: 40,
                                        color: const Color.fromARGB(
                                          255,
                                          0,
                                          72,
                                          130,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        'Living Room Light',
                                        style: GoogleFonts.interTight(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Status: '),
                                          Text(
                                            logProvider.isLightOn
                                                ? 'ON'
                                                : 'OFF',
                                            style: GoogleFonts.interTight(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Text('Tap to switch the light.'),
                                      SizedBox(height: 30),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder:
                                                      (
                                                        context,
                                                        animation1,
                                                        animation2,
                                                      ) => Details(
                                                        id: '1',
                                                        type: 'light',
                                                        title:
                                                            'Living Room Light',
                                                        state: logProvider
                                                            .isLightOn,
                                                      ),
                                                  transitionDuration:
                                                      Duration.zero,
                                                  reverseTransitionDuration:
                                                      Duration.zero,
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              overlayColor: Colors.transparent,
                                              shadowColor: Colors.transparent,
                                            ),
                                            child: Text(
                                              'Details',
                                              style: GoogleFonts.interTight(
                                                color: Colors.lightBlue,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          ElevatedButton(
                                            onPressed: () {
                                              logProvider.toggleLight();
                                            },
                                            child: Text(
                                              logProvider.isLightOn
                                                  ? 'Turn OFF'
                                                  : 'Turn ON',
                                              style: GoogleFonts.interTight(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(70, 99, 99, 99),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 8, top: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.door_back_door,
                                        size: 40,
                                        color: const Color.fromARGB(
                                          255,
                                          0,
                                          72,
                                          130,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        'Front Door',
                                        style: GoogleFonts.interTight(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Door: '),
                                          Text(
                                            logProvider.isDoorOpen
                                                ? 'UNLOCKED'
                                                : 'LOCKED',
                                            style: GoogleFonts.interTight(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Text('Tap to lock / unlock the door.'),
                                      SizedBox(height: 30),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder:
                                                      (
                                                        context,
                                                        animation1,
                                                        animation2,
                                                      ) => Details(
                                                        id: '2',
                                                        type:
                                                            'door', // Changed from 'Door' to 'door'
                                                        title: 'Front Door',
                                                        state: logProvider
                                                            .isDoorOpen,
                                                      ),
                                                  transitionDuration:
                                                      Duration.zero,
                                                  reverseTransitionDuration:
                                                      Duration.zero,
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              overlayColor: Colors.transparent,
                                              shadowColor: Colors.transparent,
                                            ),
                                            child: Text(
                                              'Details',
                                              style: GoogleFonts.interTight(
                                                color: Colors.lightBlue,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          ElevatedButton(
                                            onPressed: () {
                                              logProvider.toggleDoor();
                                            },
                                            child: Text(
                                              logProvider.isDoorOpen
                                                  ? 'Lock'
                                                  : 'Unlock',
                                              style: GoogleFonts.interTight(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Slider Controlled Devices',
                        style: GoogleFonts.interTight(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 220,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(95, 244, 67, 54),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 8, top: 8),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.thermostat,
                                        size: 40,
                                        color: const Color.fromARGB(
                                          255,
                                          0,
                                          72,
                                          130,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        'Termostat',
                                        style: GoogleFonts.interTight(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Set point: '),
                                            Text(
                                              '${logProvider.temperature.toStringAsFixed(1)}°C',
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          'Use slider to change temperature.',
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.40,
                                          child: Slider(
                                            value: logProvider.temperature,
                                            min: 10.0,
                                            max: 30.0,
                                            divisions: 20,
                                            label:
                                                '${logProvider.temperature.toStringAsFixed(1)}°C',
                                            onChanged: (double value) {
                                              logProvider.temperature = value;
                                              // ignore: invalid_use_of_protected_member
                                              logProvider.notifyListeners();
                                            },
                                            onChangeEnd: (double value) {
                                              logProvider.setTemperature(value);
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  overlayColor:
                                                      Colors.transparent,
                                                  shadowColor:
                                                      Colors.transparent,
                                                ),
                                                onPressed: () {
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder:
                                                          (
                                                            context,
                                                            animation1,
                                                            animation2,
                                                          ) => Details(
                                                            id: '3',
                                                            type: 'temperature',
                                                            title: 'Thermostat',
                                                            state:
                                                                logProvider
                                                                    .temperature >
                                                                20,
                                                          ),
                                                      transitionDuration:
                                                          Duration.zero,
                                                      reverseTransitionDuration:
                                                          Duration.zero,
                                                    ),
                                                    (route) => false,
                                                  );
                                                },
                                                child: Text(
                                                  'Details',
                                                  style: GoogleFonts.interTight(
                                                    color: Colors.blueAccent,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 220,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(52, 0, 195, 239),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 8, top: 8),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.air,
                                        size: 40,
                                        color: const Color.fromARGB(
                                          255,
                                          0,
                                          72,
                                          130,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        'Ceiling',
                                        style: GoogleFonts.interTight(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Fan speed: '),
                                            Text(
                                              logProvider.fanSpeed.toString(),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Text('0 = OFF, 3 = MAX'),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.40,
                                          child: Slider(
                                            value: logProvider.fanSpeed
                                                .toDouble(),
                                            min: 0,
                                            max: 3,
                                            divisions: 3,
                                            label: logProvider.fanSpeed
                                                .toString(),
                                            onChanged: (double value) {
                                              // Update UI without logging
                                              logProvider.fanSpeed = value
                                                  .toInt();
                                              logProvider.notifyListeners();
                                            },
                                            onChangeEnd: (double value) {
                                              // Log only when slider is released
                                              logProvider.setFanSpeed(
                                                value.toInt(),
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  overlayColor:
                                                      Colors.transparent,
                                                  shadowColor:
                                                      Colors.transparent,
                                                ),
                                                onPressed: () {
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder:
                                                          (
                                                            context,
                                                            animation1,
                                                            animation2,
                                                          ) => Details(
                                                            id: '4',
                                                            type: 'fan',
                                                            title:
                                                                'Ceiling Fan',
                                                            state:
                                                                logProvider
                                                                    .fanSpeed >
                                                                0,
                                                          ),
                                                      transitionDuration:
                                                          Duration.zero,
                                                      reverseTransitionDuration:
                                                          Duration.zero,
                                                    ),
                                                    (route) => false,
                                                  );
                                                },
                                                child: Text(
                                                  'Details',
                                                  style: GoogleFonts.interTight(
                                                    color: Colors.blueAccent,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Cameras',
                        style: GoogleFonts.interTight(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 10),
                      CameraPlayer(),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
