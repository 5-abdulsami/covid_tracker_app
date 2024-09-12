import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_tracker_app/model/cases_model.dart';
import 'package:practice_tracker_app/services/app_urls.dart';

class ApiServices {
  Future<WorldStatesModel> getWorldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.casesUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("Error while fetching data");
    }
  }

  Future<List<dynamic>> getCountriesRecords() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesUrl));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Error Occured");
    }
  }
}
