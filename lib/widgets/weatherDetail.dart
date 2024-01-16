import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherz_appz/provider/weatherProvider.dart';

class WeatherDetail extends StatelessWidget {
  const WeatherDetail({super.key});

  Widget _gridWeatherBuilder(
    String header,
    String body,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          header,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white),
        ),
        Text(
          body,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _gridWeatherBuilder(
                  'Wind Speed',
                  '${weatherProv.weather!.windSpeed} km/h',
                ),
                _gridWeatherBuilder(
                  'Humidity',
                  '${weatherProv.weather!.humidity}%',
                ),
                _gridWeatherBuilder(
                  'Visibility',
                  '${weatherProv.weather!.visibility}',
                ),
                _gridWeatherBuilder(
                  'Pressure',
                  '${weatherProv.weather!.pressure} hPa',
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
