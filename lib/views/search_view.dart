import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_search_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_search_app/models/weather_model.dart';
import 'package:weather_search_app/services/weather_service.dart'; // Import the WeatherService

class SearchView extends StatelessWidget {
  final WeatherService _weatherService = WeatherService();

  SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter A City Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) async {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }
              return await _weatherService.getLocationHints(
                  query: textEditingValue.text);
            },
            onSelected: (String selection) {
              // Extract the city name from the selection (e.g., "London, United Kingdom" -> "London")
              final cityName = selection.split(',').first.trim();
              // Update the TextField with only the city name
              final textEditingController = _textEditingController;
              textEditingController.text = cityName;
              textEditingController.selection =
                  TextSelection.collapsed(offset: cityName.length);
            },
            fieldViewBuilder: (
              BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted,
            ) {
              // Store the TextEditingController for later use
              _textEditingController = textEditingController;
              return TextField(
                onSubmitted: (value) async {
                  BlocProvider.of<GetWeatherStatesCubit>(context)
                      .getWeather(cityName: _textEditingController.text);
                  Navigator.pop(context);
                },
                controller: textEditingController,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 24,
                  ),
                  labelText: 'Search',
                  hintText: 'Enter a City Name',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              );
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4.0,
                  child: SizedBox(
                    height:
                        200.0, // Set a fixed height for the suggestions list
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options.elementAt(index);
                        return ListTile(
                          title: Text(option),
                          onTap: () {
                            // Call onSelected with the full suggestion
                            onSelected(option);
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Store the TextEditingController for later use
  late final TextEditingController _textEditingController;
}
