import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
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
    // Update chart every 5 seconds for real-time updates
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (mounted) {
        // Update power data every 5 seconds
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
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            primaryXAxis: NumericAxis(
                              isVisible: true,
                              title: AxisTitle(text: 'Время (сек)'),
                              majorGridLines: const MajorGridLines(width: 0),
                            ),
                            primaryYAxis: NumericAxis(
                              title: AxisTitle(text: 'Мощность (кВт)'),
                              labelFormat: '{value} kW',
                              majorGridLines: const MajorGridLines(width: 0.5),
                              axisLine: const AxisLine(width: 0),
                              minimum: 0,
                              maximum: 10,
                            ),
                            tooltipBehavior: TooltipBehavior(
                              enable: true,
                              format: 'point.x: point.y kW',
                            ),
                            series: <CartesianSeries>[
                              LineSeries<PowerData, int>(
                                dataSource: List.generate(
                                  logProvider.powerUsage.length,
                                  (index) => PowerData(
                                    index,
                                    logProvider.powerUsage[index],
                                  ),
                                ),
                                xValueMapper: (PowerData data, _) => data.time,
                                yValueMapper: (PowerData data, _) => data.power,
                                color: Colors.lightBlue,
                                width: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.lightBlue),
                        ),
                        child: Row(
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
                                    fontSize: 28,
                                    color: Colors.lightBlue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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

class PowerData {
  PowerData(this.time, this.power);
  final int time;
  final double power;
}
