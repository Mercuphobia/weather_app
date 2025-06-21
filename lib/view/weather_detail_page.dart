import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/repository/weather_repository.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';
import 'package:go_router/go_router.dart';

class WeatherDetailPage extends StatelessWidget {
  final String city;
  const WeatherDetailPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherCubit(WeatherRepository())..fetchWeather(city),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Thời tiết: $city'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/');
            },
          ),
        ),
        body: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (_, state) {
            if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoaded) {
              final weather = state.weather;
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weather.city,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.network(
                        'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
                        width: 100,
                        height: 100,
                      ),
                      Text(
                        '${weather.temperature.toStringAsFixed(1)}°C',
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        weather.description,
                        style: const TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: () => context.go('/'),
                        icon: const Icon(Icons.home),
                        label: const Text('Quay về trang chính'),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is WeatherError) {
              return Center(
                child: Text('Lỗi: ${state.message}', style: const TextStyle(color: Colors.red)),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
