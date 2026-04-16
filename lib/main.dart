import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

MaterialColor getThemeColor(String? condition) {
  String? cond;
  if (condition == null) {
    return Colors.blue;
  } else {
    cond = condition.toLowerCase();
  } // Sunny/Clear
  if (cond == 'sunny') {
    return Colors.amber;
  }
  if (cond == 'clear') {
    return Colors.indigo;
  }

  // Partly cloudy
  if (cond.contains('partly cloudy')) {
    return Colors.blueGrey;
  }

  // Cloudy/Overcast
  if (cond.contains('cloudy') || cond.contains('overcast')) {
    return Colors.grey;
  }

  // Mist/Fog
  if (cond.contains('mist') || cond == 'fog' || cond.contains('freezing fog')) {
    return Colors.grey;
  }

  // Rain conditions
  if (cond.contains('drizzle') ||
      cond.contains('rain') ||
      cond.contains('shower')) {
    if (cond.contains('thunder')) {
      return Colors.deepPurple;
    }
    return Colors.blue;
  }

  // Freezing conditions
  if (cond.contains('freezing')) {
    return Colors.lightBlue;
  }

  // Snow conditions
  if (cond.contains('snow') ||
      cond.contains('blizzard') ||
      cond.contains('blowing snow')) {
    return Colors.cyan;
  }

  // Sleet conditions
  if (cond.contains('sleet')) {
    return Colors.lightBlue;
  }

  // Ice pellets
  if (cond.contains('ice pellets')) {
    return Colors.teal;
  }

  // Thunder/Storm conditions
  if (cond.contains('thunder') || cond.contains('thundery')) {
    return Colors.deepPurple;
  }

  // Default
  return Colors.grey;
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<GetWeatherCubit, WeatherStates>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: getThemeColor(
                    BlocProvider.of<GetWeatherCubit>(
                      context,
                    ).weather?.currentWeatherCondition,
                  ),
                  useMaterial3: false,
                ),
                home: HomeView(),
              );
            },
          );
        },
      ),
    );
  }
}
