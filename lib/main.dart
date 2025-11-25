import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('Smart Home Controller'),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  overlayColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  'Overview',
                  style: GoogleFonts.interTight(
                    fontSize: 15,
                    color: Colors.lightBlue,
                  ),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  overlayColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  'Statistic',
                  style: GoogleFonts.interTight(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          centerTitle: false,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ON/Off devices',
                style: GoogleFonts.interTight(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    height: 200,
                    width: screenWidth * 0.40,
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
                                color: const Color.fromARGB(255, 0, 72, 130),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [Text('Status: ')]),
                              SizedBox(height: 20),
                              Text('Tap to switch the light.'),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
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
                                    onPressed: () {},
                                    child: Text('Turn OFF/ON'),
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
                  SizedBox(width: 20),
                  Container(
                    height: 200,
                    width: screenWidth * 0.40,
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
                                color: const Color.fromARGB(255, 0, 72, 130),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [Text('Door: ')]),
                              SizedBox(height: 20),
                              Text('Tap to lock / unlock the door.'),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
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
                                    onPressed: () {},
                                    child: Text('Unlock'),
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
            ],
          ),
        ),
      ),
    );
  }
}
