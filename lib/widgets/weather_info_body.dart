import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/widgets/glass_card.dart';
import 'package:weather_app/widgets/info_item.dart';

class WeatherInfoBody extends StatelessWidget {
  final WeatherModel weatherModel;

  const WeatherInfoBody({
    super.key,
    required this.weatherModel,
  });

  BoxDecoration bodyDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          getThemeColor(weatherModel.currentWeatherCondition),
          Colors.white,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bodyDecoration(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              buildHeader(),
              const SizedBox(height: 30),
              buildMainCard(),
              const SizedBox(height: 20),
              buildConditionCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildConditionCard() {
    return GlassCard(
      child: Column(
        children: [
          const Text(
            'Forecast',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: weatherModel.forecastWeatherConditionImage!,
                height: 32,
                width: 32,
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, size: 28),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  weatherModel.forecastWeatherCondition!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Column(
      children: [
        Text(
          weatherModel.cityName,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Last updated at ${weatherModel.lastUpdated.hour}:${weatherModel.lastUpdated.minute}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget buildMainCard() {
    return GlassCard(
      child: Column(
        children: [
          // 🔹 Current condition (NEW)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: weatherModel.currentWeatherConditionImage!,
                height: 40,
                width: 40,
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, size: 30),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  weatherModel.currentWeatherCondition!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 🔹 Temperature
          Text(
            '${weatherModel.currentTemp.toInt()}°',
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.white.withValues(alpha: 0.3)),
          const SizedBox(height: 10),

          // 🔹 Max / Min
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InfoItem(
                icon: Icons.arrow_upward,
                label: 'Max',
                value: weatherModel.maxTemp.toString(),
              ),
              InfoItem(
                icon: Icons.arrow_downward,
                label: 'Min',
                value: weatherModel.minTemp.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
