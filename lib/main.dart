import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_search_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_search_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_search_app/views/home_view.dart';

void main() async {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherStatesCubit(),
      child: Builder(
        builder: (context) => BlocBuilder<GetWeatherStatesCubit, WeatherState>(
            builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: false,
              primarySwatch: getThemeColor(
                  BlocProvider.of<GetWeatherStatesCubit>(context)
                      .weatherModel
                      ?.weatherConditon),
            ),
            debugShowCheckedModeBanner: false,
            home: const HomeView(),
          );
        }),
      ),
    );
  }
}

MaterialColor getThemeColor(String? weatherDescription) {
  switch (weatherDescription?.toLowerCase()) {
    case null:
      return Colors.blue;
    // Sunny / Clear
    case 'sunny':
    case 'clear':
      return Colors.orange;

    // Partly Cloudy
    case 'partly cloudy':
      return Colors.lightBlue;

    // Cloudy / Overcast
    case 'cloudy':
    case 'overcast':
      return Colors.blueGrey;

    // Mist / Fog
    case 'mist':
    case 'fog':
    case 'freezing fog':
      return Colors.grey;

    // Rain
    case 'patchy rain possible':
    case 'light rain':
    case 'moderate rain':
    case 'heavy rain':
    case 'patchy light rain':
    case 'moderate rain at times':
    case 'heavy rain at times':
    case 'light freezing rain':
    case 'moderate or heavy freezing rain':
    case 'light rain shower':
    case 'moderate or heavy rain shower':
    case 'torrential rain shower':
      return Colors.blue;

    // Thunderstorms
    case 'thundery outbreaks possible':
    case 'patchy light rain with thunder':
    case 'moderate or heavy rain with thunder':
      return Colors.deepPurple;

    // Snow
    case 'patchy snow possible':
    case 'light snow':
    case 'moderate snow':
    case 'heavy snow':
    case 'patchy light snow':
    case 'patchy moderate snow':
    case 'patchy heavy snow':
    case 'light snow showers':
    case 'moderate or heavy snow showers':
    case 'blowing snow':
    case 'blizzard':
      return Colors.lightBlue;

    // Sleet
    case 'patchy sleet possible':
    case 'light sleet':
    case 'moderate or heavy sleet':
    case 'light sleet showers':
    case 'moderate or heavy sleet showers':
      return Colors.teal;

    // Freezing Drizzle / Ice Pellets
    case 'patchy freezing drizzle possible':
    case 'freezing drizzle':
    case 'heavy freezing drizzle':
    case 'light showers of ice pellets':
    case 'moderate or heavy showers of ice pellets':
    case 'ice pellets':
      return Colors.cyan;

    // Extreme Weather
    case 'thunderstorm':
    case 'storm':
      return Colors.deepOrange;

    // Default for unknown conditions
    default:
      return Colors.blue;
  }
}
