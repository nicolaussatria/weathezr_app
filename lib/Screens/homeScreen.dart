import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/weatherProvider.dart';

import '../widgets/locationError.dart';
import '../widgets/mainWeather.dart';
import '../widgets/requestError.dart';

import '../widgets/weatherDetail.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future<void> _getData() async {
    _isLoading = true;
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    weatherData.getWeatherData(context);
    _isLoading = false;
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false)
        .getWeatherData(context, isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer<WeatherProvider>(
          builder: (context, weatherProv, _) {
            if (weatherProv.isRequestError) return const RequestError();
            if (weatherProv.isLocationError) return const LocationError();
            return Column(
              children: [
                _isLoading || weatherProv.isLoading
                    ? Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: themeContext.primaryColor,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async => _refreshData(context),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: const Column(
                              children: [
                                Center(
                                  heightFactor: 2,
                                  child: MainWeather(),
                                ),
                                WeatherDetail(),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
