import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/weather_model.dart';

class APICallProvider with ChangeNotifier {
  bool _dataIsAvailable = false;
  get dataIsAvailable => dataIsAvailable;
  set dataIsAvailable(value) {
    _dataIsAvailable = value;
    notifyListeners();
  }

  Future fetchApiData(String city) async {
    var response = await http.get(Uri.parse(
        'https://api.tomorrow.io/v4/weather/forecast?location=$city&apikey=AbttBN72a24jcYAJKFrBxgzOw1G1qEoo'));
    print(response.body);
    var r1 = jsonDecode(response.body);
    print(r1);
    return WeatherResponseModel.fromJson(r1);
  }
}
//https://api.openweathermap.org/data/2.5/weather?q=$city&appid=48514c1b8b7c2b1a6695b46b8a1274d4
