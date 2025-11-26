import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_controller/appbar.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _MainAppState();
}

class _MainAppState extends State<Statistics> {
  bool isLightOn = false;
  bool isDoorOpen = false;
  double temperature = 10.0;
  int fanSpeed = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(appBar: BarApp(currentPage: 'stats')),
    );
  }
}
