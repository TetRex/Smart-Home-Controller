import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_controller/main.dart';
import 'package:smart_home_controller/statistics.dart';

class BarApp extends StatelessWidget implements PreferredSizeWidget {
  final String currentPage;
  final List<String> actionLog;
  final Color selectedColor = Colors.lightBlue;
  final Color unselectedColor = Colors.black;
  const BarApp({super.key, required this.currentPage, required this.actionLog});
  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text('Smart Home Controller'),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const MainApp(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
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
                color: currentPage == 'home' ? selectedColor : unselectedColor,
              ),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      Statistics(actionLog: actionLog),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              overlayColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: Text(
              'Statistic',
              style: GoogleFonts.interTight(
                color: currentPage == 'stats' ? selectedColor : unselectedColor,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      centerTitle: false,
    );
  }
}
