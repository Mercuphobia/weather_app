import 'package:flutter_bloc/flutter_bloc.dart';

class CityCubit extends Cubit<List<String>>{
  CityCubit() : super([]);

  void addCity(String city){
    final nomalized = city.trim().toLowerCase();
    if(nomalized.isNotEmpty && !state.contains(nomalized)){
      emit([...state, nomalized]);
    }
  }

  void removeCity(String city){
    emit(state.where((t) => t != city).toList());
  }
}