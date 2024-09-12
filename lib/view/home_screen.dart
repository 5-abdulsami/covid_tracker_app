import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:practice_tracker_app/model/cases_model.dart';
import 'package:practice_tracker_app/view/countries_list_screen.dart';
import 'package:practice_tracker_app/view_model/countries_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  ApiServices apiServices = ApiServices();
  late final AnimationController controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 5))
        ..repeat();
  final colorList = <Color>[Colors.blue, Colors.green, Colors.red];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text(
          'Home Screen',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: apiServices.getWorldStatesRecords(),
        builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: SpinKitCubeGrid(
                color: Colors.white,
              ),
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  height: height * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: PieChart(
                      dataMap: {
                        "Total": double.parse(snapshot.data!.cases.toString()),
                        "Recovered":
                            double.parse(snapshot.data!.recovered.toString()),
                        "Deaths":
                            double.parse(snapshot.data!.deaths.toString()),
                      },
                      chartType: ChartType.ring,
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true,
                      ),
                      colorList: colorList,
                      chartRadius: 150,
                      animationDuration: const Duration(milliseconds: 1200),
                      legendOptions: const LegendOptions(
                          showLegends: true,
                          legendPosition: LegendPosition.left,
                          legendTextStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[800],
                  ),
                  width: width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(children: [
                      ReusableRow(
                          title: 'Total Cases',
                          value: snapshot.data!.cases.toString()),
                      ReusableRow(
                          title: 'Total Recovered',
                          value: snapshot.data!.recovered.toString()),
                      ReusableRow(
                          title: 'Total Deaths',
                          value: snapshot.data!.deaths.toString()),
                      ReusableRow(
                          title: 'Today Cases',
                          value: snapshot.data!.todayCases.toString()),
                      ReusableRow(
                          title: 'Today Deaths',
                          value: snapshot.data!.todayDeaths.toString()),
                      ReusableRow(
                          title: 'Today Recovered', value: 200.toString()),
                    ]),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                const CountriesListScreen())));
                  },
                  child: Container(
                    height: 50,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                      'Track Countries',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title;
  String value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(),
      ],
    );
  }
}

// FutureBuilder(
//                 future: apiServices.getWorldwideRecords(),
//                 builder: (context, snapshot) {
//                   return Column(children: [
//                     ReusableRow(
//                         title: 'Total Cases',
//                         value: snapshot.data!.cases.toString()),
//                     ReusableRow(
//                         title: 'Total Recovered',
//                         value: snapshot.data!.recovered.toString()),
//                     ReusableRow(
//                         title: 'Total Deaths',
//                         value: snapshot.data!.deaths.toString()),
//                     ReusableRow(
//                         title: 'Today Cases',
//                         value: snapshot.data!.todayCases.toString()),
//                     ReusableRow(
//                         title: 'Today Deaths',
//                         value: snapshot.data!.todayDeaths.toString()),
//                     ReusableRow(
//                         title: 'Today Recovered',
//                         value: snapshot.data!.todayRecovered.toString()),
//                   ]);
//                 },
//               ),