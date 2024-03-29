import 'package:covid_tracker_app/View/WorldStates.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;

  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      todayRecovered,
      test,
      critical;
  DetailScreen(
      {required this.name,
      required this.image,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.todayRecovered,
      required this.test,
      required this.critical});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.grey.shade800,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.067),
                  child: Card(
                    color: Colors.grey.shade800,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          ReusableRow(
                              title: 'Cases',
                              value: widget.totalCases.toString()),
                          ReusableRow(
                              title: 'Recovered',
                              value: widget.totalRecovered.toString()),
                          ReusableRow(
                              title: 'Deaths',
                              value: widget.totalDeaths.toString()),
                          ReusableRow(
                              title: 'Critical',
                              value: widget.critical.toString()),
                          ReusableRow(
                              title: 'Today Recovered',
                              value: widget.todayRecovered.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
