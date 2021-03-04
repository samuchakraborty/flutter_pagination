import 'dart:convert';

import 'package:http/http.dart' as http;

import 'config.dart';
import 'models/data_model.dart';

class APIService {
  Future<LoadDataPagination> getData(pageNumber) async {
    String url =
        "?page=$pageNumber";

  //  print("URL : $url");
    print(Config.apiURL + url);
    final response = await http.get(Config.apiURL + url);
    if (response.statusCode == 200) {
      return LoadDataPagination.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
