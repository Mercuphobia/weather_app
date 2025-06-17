
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherRepository {
  final String apiKey = '9d28b3a7a7ae5bb89c43d46be45ad0cc';

  Future<Weather> fetchWeather(String city) async{
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey&lang=vi';

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    }
    else{
      throw Exception('khong tim thay thanh pho');
    }
  }
}