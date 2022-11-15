import 'package:flutter/material.dart';
import 'package:weather_forecast/route/route_names.dart';
import 'package:weather_forecast/ui/forecast/forecast.dart';
import 'package:weather_forecast/ui/other/page_not_found.dart';
import 'package:weather_forecast/ui/weather/weather_detail.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    var routes = <String, WidgetBuilder>{
      forecastRoute: (_) => const Forecast(),
      weatherRoute: (_) => WeatherDetail(
            dataParam: args,
          ),
    };
    WidgetBuilder? builder = routes[settings.name];
    return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (ctx) =>
            builder == null ? const PageNotFound() : builder(ctx));
  }

  static Route<dynamic>? errorRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) {
        return const PageNotFound();
      },
    );
  }
}
