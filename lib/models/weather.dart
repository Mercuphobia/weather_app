
class Weather{
  final String description;
  final double temperature;
  final String iconCode;
  final String city;

  Weather({
    required this.description,
    required this.temperature,
    required this.iconCode,
    required this.city,
  });

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      iconCode: json['weather'][0]['icon'],
      city: json['name'],
    );
  }
}