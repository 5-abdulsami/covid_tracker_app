import 'package:flutter/material.dart';
import 'package:practice_tracker_app/view/detail_screen.dart';
import 'package:practice_tracker_app/view_model/countries_view_model.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  ApiServices apiServices = ApiServices();
  final countryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text('Search Countries'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                setState(() {});
              },
              style: const TextStyle(color: Colors.white),
              controller: countryController,
              decoration: InputDecoration(
                  hintText: 'Search Country',
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ))),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: apiServices.getCountriesRecords(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  width: 90,
                                  height: 10,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  width: 90,
                                  height: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: ((context, index) {
                          String name = snapshot.data![index]['country'];
                          if (countryController.text.isEmpty) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => DetailScreen(
                                              name: snapshot.data![index]
                                                      ['country']
                                                  .toString(),
                                              image: snapshot.data![index]
                                                      ['countryInfo']['flag']
                                                  .toString(),
                                              totalCases: snapshot.data![index]
                                                  ['cases'],
                                              totalDeaths: snapshot.data![index]
                                                  ['deaths'],
                                              totalRecovered: snapshot
                                                  .data![index]['recovered'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                            ))));
                              },
                              child: ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']
                                      .toString()),
                                ),
                                title: Text(
                                  snapshot.data![index]['country'].toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]['cases'].toString(),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(countryController.text.toString())) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => DetailScreen(
                                              name: snapshot.data![index]
                                                      ['country']
                                                  .toString(),
                                              image: snapshot.data![index]
                                                      ['countryInfo']['flag']
                                                  .toString(),
                                              totalCases: snapshot.data![index]
                                                  ['cases'],
                                              totalDeaths: snapshot.data![index]
                                                  ['deaths'],
                                              totalRecovered: snapshot
                                                  .data![index]['recovered'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                            ))));
                              },
                              child: ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']
                                      .toString()),
                                ),
                                title: Text(
                                  snapshot.data![index]['country'].toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]['cases'].toString(),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }));
                  }
                }),
          ),
        ],
      ),
    );
  }
}
