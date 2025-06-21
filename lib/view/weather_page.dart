
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';

class WeatherPage extends StatelessWidget {
  WeatherPage({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('weather app'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'fill name city'
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.read<WeatherCubit>().fetchWeather(_controller.text);
                print(context.read<WeatherCubit>().fetchWeather(_controller.text));
              },
              child: Text('Find'),
            ),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if(state is WeatherInitial){
                  return Text('fill name city');
                }
                else if (state is WeatherLoading) {
                  return const CircularProgressIndicator();
                }
                else if (state is WeatherLoaded){
                  // vì class Loaded khi tạo có 1 đối tượng weather nên có thể dùng
                  final weather = state.weather;
                  return Column(
                    children: [
                      Text(
                        '${weather.temperature}°C',
                        style: TextStyle(fontSize: 36),
                      ),
                      Text(
                        weather.description,
                      ),
                      Image.network('https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',),
                    ],
                  );
                }
                else if (state is WeatherError) {
                  return Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

