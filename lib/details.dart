import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_controller/action_log_provider.dart';
import 'package:smart_home_controller/main.dart';

class Details extends StatefulWidget {
  final String id;
  final String type;
  final String title;
  final bool state;
  const Details({
    super.key,
    required this.id,
    required this.type,
    required this.title,
    required this.state,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<ActionLogProvider>(
        builder: (context, logProvider, child) {
          return Scaffold(
            body: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.interTight(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: ${widget.id}'),
                        Text('Type: ${widget.type}'),
                        Text(widget.state ? 'State: ON' : 'State: OFF'),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Recent actions',
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
                            itemCount: logProvider
                                // ignore: unnecessary_string_interpolations
                                .getFilteredLog('${widget.type}')
                                .length,
                            itemBuilder: (context, index) {
                              final filteredLog = logProvider.getFilteredLog(
                                // ignore: unnecessary_string_interpolations
                                '${widget.type}',
                              );
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 15,
                                ),
                                child: Text(
                                  filteredLog[index],
                                  style: GoogleFonts.interTight(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const MainApp(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                        (route) => false,
                      );
                    },
                    child: Text('Back to overview'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
