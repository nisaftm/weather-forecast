// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:weather_forecast/model/forecast_model.dart';
import 'package:weather_forecast/network/params.dart';

import '../../network/var_net.dart';
import '../../utils/utils.dart';

class WeatherDetail extends StatefulWidget {
  final dataParam;

  const WeatherDetail({super.key, required this.dataParam});

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  ForeCastList item = ForeCastList();

  String date = "";

  String hour = "";

  double temp = 0.0;
  double tempMin = 0.0;
  double tempMax = 0.0;

  String image = "";

  String weather = "";

  @override
  void initState() {
    item = widget.dataParam[paramWeather];
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Weather Details',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: body());
  }

  body() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            date,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          ),
          Text(
            hour,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${temp.toStringAsFixed(1)} \u2103',
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(
                width: 16,
              ),
              Image.network(
                image,
                width: 70,
                height: 70,
                errorBuilder: (context, object, error) {
                  return const Icon(Icons.error);
                },
              ),

            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            weather,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Temp (min)',
                      ),
                      Text(
                        '${tempMin.toStringAsFixed(1)} \u2103',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                  )),
              Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Temp (max)',
                      ),
                      Text(
                        '${tempMax.toStringAsFixed(1)} \u2103',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }

  void setData() {
    setState(() {
      String dtTxt = item.dtTxt.toString();
      date = getFormatDate(
          dtTxt, "yyyy-MM-dd HH:mm:ss", "EEEE, MMMM d, yyyy");
      hour = getFormatDate(dtTxt, "yyyy-MM-dd HH:mm:ss", "h:mm a");
      double kelvin = item.main!.temp!.toDouble();
      double kelvinMin = item.main!.tempMin!.toDouble();
      double kelvinMax = item.main!.tempMax!.toDouble();
      temp = kelvin - 273.15;
      tempMin = kelvinMin - 273.15;
      tempMax = kelvinMax - 273.15;
      String icon = item.weather!.elementAt(0).icon.toString();
      image = "$urlImage$icon@2x.png";
      String mainWeather = item.weather!.elementAt(0).main.toString();
      String descriptionWeather =
          item.weather!.elementAt(0).description.toString();
      weather = '$mainWeather ($descriptionWeather)';
    });
  }
}
