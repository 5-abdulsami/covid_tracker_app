import 'package:covid_tracker_app/Model/world_states_model.dart';
import 'package:covid_tracker_app/Services/states_services.dart';
import 'package:covid_tracker_app/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 4), vsync: this)
        ..repeat();

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(),
                  builder:
                      ((context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(
                                    snapshot.data!.cases!.toString()),
                                "Recovered": double.parse(
                                    snapshot.data!.recovered.toString()),
                                "Deaths": double.parse(
                                    snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              animationDuration: Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 2.8,
                              legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left,
                                legendTextStyle: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 40),
                              child: Card(
                                color: Colors.grey[800],
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      ReusableRow(
                                          title: 'Total',
                                          value:
                                              snapshot.data!.cases.toString()),
                                      ReusableRow(
                                          title: 'Recovered',
                                          value: snapshot.data!.recovered
                                              .toString()),
                                      ReusableRow(
                                          title: 'Deaths',
                                          value:
                                              snapshot.data!.deaths.toString()),
                                      ReusableRow(
                                          title: 'Active',
                                          value:
                                              snapshot.data!.active.toString()),
                                      ReusableRow(
                                          title: 'Critical',
                                          value: snapshot.data!.critical
                                              .toString()),
                                      ReusableRow(
                                          title: 'Today Deaths',
                                          value: snapshot.data!.todayDeaths
                                              .toString()),
                                      ReusableRow(
                                          title: 'Today Recovered',
                                          value: snapshot.data!.todayRecovered
                                              .toString()),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CountriesListScreen()));
                              },
                              child: Container(
                                child: Center(
                                    child: Text(
                                  'Track Countries',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                )),
                                decoration: BoxDecoration(
                                  color: Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 50,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  })),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              Text(
                value,
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
