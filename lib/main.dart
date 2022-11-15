import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/providers/provider_forecast.dart';
import 'package:weather_forecast/route/route_generator.dart';
import 'package:weather_forecast/route/route_names.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
        child: MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderForecast>(
            create: (_) => ProviderForecast())
      ],
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: const [Locale('id', 'ID')],
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onUnknownRoute: RouteGenerator.errorRoute,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: forecastRoute,
          navigatorKey: navigatorKey,
        );
      },
    ));
  }
}
