
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/weather_repository.dart';
import './weather_state.dart';

class WeatherCubit extends Cubit<WeatherState>{
  final WeatherRepository repository;
  // ý nghĩa của đoạn này: đối tượng của class này khi tạo cần dữ liệu thời tiết và trạng thái ban đầu là chưa load dữ liệu
  WeatherCubit(this.repository) : super(WeatherInitial());

  Future<void> fetchWeather(String city) async {
    emit(WeatherLoading());
    try {
      final weather = await repository.fetchWeather(city);
      emit(WeatherLoaded(weather));
    }
    catch (e){
      emit(WeatherError(e.toString()));
    }
  }
}
