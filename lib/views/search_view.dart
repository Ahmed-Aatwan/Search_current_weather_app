import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 32,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              hintText: 'Enter a City Name',
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
            ),
            onSubmitted: (value) async {
              value = _controller.text.trim();
              BlocProvider.of<GetWeatherCubit>(
                context,
              ).getWeather(cityName: value);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
