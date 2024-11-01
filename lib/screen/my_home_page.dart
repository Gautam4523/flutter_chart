import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart/screen/details_page.dart';
import 'package:flutter_chart/screen/search_bar.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../model/data_model.dart';

class ChartApp extends StatefulWidget {
  const ChartApp({super.key});

  @override
  State<ChartApp> createState() => _ChartAppState();
}

class _ChartAppState extends State<ChartApp> {
  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Revenue Bar Chart'),
        actions: [
          Search(
              width: 200,
              hintText: 'Search by company ticker',
              searchText: (searchText) {
                if (searchText.isNotEmpty) {
                  controller.setSearchText(searchText.trim());
                  controller.fetchData();
                } else {
                  controller.setSearchText('');
                  controller.fetchData();
                }
              }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.dataList.isEmpty) {
          return Center(child: Text('No record found'));
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: BarChart(
            BarChartData(
              maxY: 70,
              barGroups: controller.dataList.asMap().entries.map((entry) {
                int index = entry.key;
                DataModel data = entry.value;

                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: data.actualRevenue! / 1e9,
                      color: Colors.green,
                      width: 15,
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 70,
                        color: Colors.green.withOpacity(0.1),
                      ),
                    ),
                    BarChartRodData(
                      toY: data.estimatedRevenue! / 1e9,
                      color: Colors.blue,
                      width: 15,
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 70,
                        color: Colors.blue.withOpacity(0.1),
                      ),
                    ),
                  ],
                );
              }).toList(),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text('${value.toInt()}B');
                    },
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        controller.dataList[value.toInt()].pricedate ?? '',
                        style: TextStyle(fontSize: 10),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  left: BorderSide(color: Colors.black, width: 1),
                  bottom: BorderSide(color: Colors.black, width: 1),
                ),
              ),
              barTouchData: BarTouchData(
                touchCallback:
                    (FlTouchEvent event, BarTouchResponse? response) {
                  if (event is FlTapUpEvent && response != null) {
                    final index = response.spot?.touchedBarGroupIndex;
                    if (index != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(index: index),
                          ));
                    }
                  }
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
