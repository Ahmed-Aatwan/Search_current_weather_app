import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_search_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_search_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_search_app/views/no_weather_view.dart';
import 'package:weather_search_app/views/search_view.dart';
import 'package:weather_search_app/views/weather_info_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Finder'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SearchView();
                  },
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<GetWeatherStatesCubit, WeatherState>(
          builder: (context, state) {
        if (state is WeatherLoadedSuccessfullyState) {
          return WeatherInfoView(
            weatherModel: state.weatherModel,
          );
        } else if (state is WeatherInitialState) {
          return const NoWeatherView();
        } else if (state is WeatherFailedLoadingState) {
          return ErrorWidget(state.errMessage);
        } else {
          return const NoWeatherView();
        }
      }),
    );
  }
}
