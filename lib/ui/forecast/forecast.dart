import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/model/forecast_model.dart';
import 'package:weather_forecast/network/params.dart';
import 'package:weather_forecast/network/var_net.dart';
import 'package:weather_forecast/providers/provider_forecast.dart';
import 'package:weather_forecast/route/route_names.dart';
import 'package:weather_forecast/utils/utils.dart';

class Forecast extends StatefulWidget {
  const Forecast({Key? key}) : super(key: key);

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  ProviderForecast? providerForecast;

  @override
  void initState() {
    providerForecast = Provider.of<ProviderForecast>(context, listen: false);
    providerForecast!.getForecast(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Weather App',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: body());
  }

  body() {
    return context.watch<ProviderForecast>().isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : context.watch<ProviderForecast>().message.isEmpty
            ? ListView.builder(
                itemCount: providerForecast!.forecastList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return weatherItem(
                      providerForecast!.forecastList.elementAt(index));
                })
            : Center(
                child: Text(context.watch<ProviderForecast>().message),
              );
  }

  weatherItem(ForeCastList item) {
    String icon = item.weather!.elementAt(0).icon.toString();
    String date = getFormatDate(
        item.dtTxt.toString(), "yyyy-MM-dd HH:mm:ss", "E, MMM d, yyyy h:mm a");
    String image = "$urlImage$icon@2x.png";
    String weather = item.weather!.elementAt(0).main.toString();
    double kelvin = item.main!.temp!.toDouble();
    double temp = kelvin - 273.15;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: (){
            Navigator.pushNamed(context, weatherRoute, arguments: {
              paramWeather: item
            });
          },
          leading: Image.network(
            image,
            errorBuilder: (context, object, error) {
              return const Icon(Icons.error);
            },
          ),
          title: Text(
            date,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                weather,
              ),
              Text(
                '${temp.toStringAsFixed(1)} \u2103',
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          color: Colors.grey.withOpacity(0.5),
        )
      ],
    );
  }
}
