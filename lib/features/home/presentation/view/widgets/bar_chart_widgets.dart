import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tab_cach/constant.dart';

class BarChartSample2 extends StatefulWidget {
  BarChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

        Expanded(
          child: BarChart(
            BarChartData(
              maxY: 30,

              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.grey,
                  getTooltipItem: (a, b, c, d) => null,
                ),
                touchCallback: (FlTouchEvent event, response) {
                  if (response == null || response.spot == null) {
                    setState(() {
                      touchedGroupIndex = -1;
                      showingBarGroups = List.of(rawBarGroups);
                    });
                    return;
                  }

                  touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                  setState(() {
                    if (!event.isInterestedForInteractions) {
                      touchedGroupIndex = -1;
                      showingBarGroups = List.of(rawBarGroups);
                      return;
                    }
                    showingBarGroups = List.of(rawBarGroups);
                    if (touchedGroupIndex != -1) {
                      var sum = 0.0;
                      for (final rod
                          in showingBarGroups[touchedGroupIndex].barRods) {
                        sum += rod.toY;
                      }
                      final avg = sum /
                          showingBarGroups[touchedGroupIndex]
                              .barRods
                              .length;

                      showingBarGroups[touchedGroupIndex] =
                          showingBarGroups[touchedGroupIndex].copyWith(
                        barRods: showingBarGroups[touchedGroupIndex]
                            .barRods
                            .map((rod) {
                          return rod.copyWith(toY: avg, color: kTextkColor);
                        }).toList(),
                      );
                    }
                  });
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: bottomTitles,
                    reservedSize: 42,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize:35,
                    interval: 1,
                    getTitlesWidget: leftTitles,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: showingBarGroups,
              gridData: FlGridData(show: false),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: kTextChartColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '0K';
    } else if (value == 10) {
      text = '10K';
    } else if (value == 20) {
      text = '20K';
    }

    else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'fab'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: kTextChartColor,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: kButtomBack,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: kExpenseColor,
          width: width,
        ),
      ],
    );
  }

}
