import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smart_home_controller/action_log_provider.dart';
import 'package:smart_home_controller/appbar.dart';
import 'dart:async';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Update chart every 1 second for real-time updates
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        // Update power data every second
        final logProvider = Provider.of<ActionLogProvider>(
          context,
          listen: false,
        );
        logProvider.updatePowerUsageRealTime();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer<ActionLogProvider>(
      builder: (context, logProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: BarApp(currentPage: 'stats', logProvider: logProvider),
            body: ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Power Consumption (Live)',
                            style: GoogleFonts.interTight(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Live',
                                  style: GoogleFonts.interTight(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(show: true),
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      const titles = [
                                        'Mon',
                                        'Tue',
                                        'Wed',
                                        'Thu',
                                        'Fri',
                                        'Sat',
                                        'Sun',
                                      ];
                                      if (value.toInt() < titles.length) {
                                        return Text(titles[value.toInt()]);
                                      }
                                      return Text('');
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: true),
                                ),
                              ),
                              borderData: FlBorderData(show: true),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: List.generate(
                                    logProvider.powerUsage.length,
                                    (index) => FlSpot(
                                      index.toDouble(),
                                      logProvider.powerUsage[index],
                                    ),
                                  ),
                                  isCurved: true,
                                  color: Colors.lightBlue,
                                  barWidth: 3,
                                  dotData: FlDotData(show: true),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Colors.lightBlue.withOpacity(0.3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Current Power',
                                style: GoogleFonts.interTight(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                '${logProvider.powerUsage.last.toStringAsFixed(2)} kW',
                                style: GoogleFonts.interTight(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.lightBlue,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Weekly Average',
                                style: GoogleFonts.interTight(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                '${(logProvider.powerUsage.reduce((a, b) => a + b) / logProvider.powerUsage.length).toStringAsFixed(2)} kW',
                                style: GoogleFonts.interTight(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Action Log',
                        style: GoogleFonts.interTight(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: screenHeight * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey[400]!),
                        ),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
