//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import './cubit/weather_cubit.dart';
// import './repository/weather_repository.dart';
//
//
// void main(){
//   runApp(const WeatherApp());
// }
//
// class WeatherApp extends StatelessWidget {
//   const WeatherApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (_) => WeatherCubit(WeatherRepository()),
//         child: MaterialApp(
//           home: WeatherPage(),
//         ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import './cubit/city_cubit.dart';
import './view/weather_page.dart';
import './view/weather_detail_page.dart';

void main() {
  runApp(MyApp());
}

final _router = GoRouter(routes: [
  GoRoute(path: '/', builder: (_, __) => WeatherPage()),
  GoRoute(path: '/weather/:city', builder: (context, state) {
    final city = state.pathParameters['city']!;
    return WeatherDetailPage(city: city);
  }),
]);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CityCubit(),
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Weather App',
        theme: ThemeData(primarySwatch: Colors.blue),
      ),
    );
  }
}

