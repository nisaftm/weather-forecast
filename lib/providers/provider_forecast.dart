import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_forecast/model/forecast_model.dart';
import 'package:weather_forecast/network/params.dart';

import '../network/var_net.dart';

class ProviderForecast extends ChangeNotifier {
  List<ForeCastList> forecastList = [];

  String message = "";

  bool isLoading = false;

  void getForecast(BuildContext context) async {
    isLoading = true;
    forecastList.clear();
    message = "";
    String url = api + forecastEndpoint;
    var queryParams = {'lat': latitude, 'lon': longitude, 'appid': apiKey};

    try {
      var response = await Dio().get(url, queryParameters: queryParams);
      var res = ForecastModel.fromJson(response.data);
      if (res.cod == "200") {
        for (var element in res.list!) {
          forecastList.add(element);
        }
        isLoading = false;
        notifyListeners();
      } else {
        message = "Failed to load";
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      message = "Something went wrong";
      isLoading = false;
      notifyListeners();
    }
  }
}
