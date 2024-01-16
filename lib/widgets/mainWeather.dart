import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherz_appz/provider/weatherProvider.dart';

class MainWeather extends StatelessWidget {
  final TextStyle _style1 = const TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontSize: 20,
  );
  final TextStyle _headtext = const TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontSize: 50,
  );

  const MainWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
      Widget weatherIcon() {
        return Container(
          height: MediaQuery.sizeOf(context).height * 0.15,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${weatherProv.weather!.weatherIcon}@4x.png"),
            ),
          ),
        );
      }

      return Container(
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(weatherProv.weather!.cityName, style: _headtext),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.51),
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  weatherIcon(),
                  Text(
                    '${weatherProv.weather!.temp.toStringAsFixed(0)}°C',
                    style: _headtext.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            const SizedBox(height: 5.0),
            Text(
              toBeginningOfSentenceCase(weatherProv.weather!.description) ?? '',
              style: _style1.copyWith(fontSize: 20),
            ),
          ],
        ),
      );
    });
  }
}
