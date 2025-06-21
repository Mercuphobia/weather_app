import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './cubit/weather_cubit.dart';
import './repository/weather_repository.dart';
import './view/weather_page.dart';



void main(){
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => WeatherCubit(WeatherRepository()),
      child: MaterialApp(
        home: WeatherPage(),
      ),
    );
  }
}
