import 'package:flutter/material.dart';

import 'home_screen.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  String name, image;
  int totalCases, totalDeaths, totalRecovered, critical, active, todayRecovered;

  DetailScreen(
      {super.key,
      required this.name,
      required this.image,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.12),
                child: Card(
                  color: Colors.grey[800],
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ReusableRow(
                          title: 'Total Cases',
                          value: widget.totalCases.toString(),
                        ),
                        ReusableRow(
                          title: 'Total Recovered',
                          value: widget.totalRecovered.toString(),
                        ),
                        ReusableRow(
                          title: 'Total Deaths',
                          value: widget.totalDeaths.toString(),
                        ),
                        ReusableRow(
                          title: 'Critical',
                          value: widget.critical.toString(),
                        ),
                        ReusableRow(
                          title: 'Active Cases',
                          value: widget.active.toString(),
                        ),
                        ReusableRow(
                          title: 'Today Recovered',
                          value: widget.todayRecovered.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.image),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
