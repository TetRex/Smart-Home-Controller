import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_controller/action_log_provider.dart';
import 'package:smart_home_controller/appbar.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer<ActionLogProvider>(
      builder: (context, logProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: BarApp(
              currentPage: 'stats',
              logProvider: logProvider, // Now logProvider is defined
            ),
            body: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Action Log',
                    style: GoogleFonts.interTight(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: screenHeight * 0.70,
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: logProvider.actionLog.isEmpty
                        ? Center(
                            child: Text(
                              'No actions yet',
                              style: GoogleFonts.interTight(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: logProvider.actionLog.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 15,
                                ),
                                child: Text(
                                  logProvider.actionLog[index],
                                  style: GoogleFonts.interTight(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
