import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todquest/bussines_logic/page2_bloc/page_2_event.dart';
import 'package:todquest/bussines_logic/page2_bloc/page_2_state.dart';

import '../../data/user_model.dart';

class Page2Bloc extends Bloc<Page2Event,Page2State> {
  List<User> listOfUser;
  Page2Bloc({required this.listOfUser}) : super(Page2InitialState()) {
    
    on<Page2InitialEvent>((event, emit) => {
      emit(Page2WorkingState(listOfUser: listOfUser))
    });
    
    List<User> tempList;
    on<Page2SearchEvent>((event, emit) => {
      emit(Page2LoadingState()),
      tempList = event.listOfUsers,
      tempList = tempList.where((element) => (element.email.toLowerCase().contains(event.value.toLowerCase())|| element.email.toLowerCase().contains(event.value.toLowerCase()))).toList(),
      emit(Page2WorkingState(listOfUser: tempList))
    });

    on<Page2FilterEvent>((event, emit) => {
      emit(Page2LoadingState()),
      tempList = event.listOfUsers,
      tempList = tempList.where((element) => (element.from.toLowerCase().contains(event.value.toLowerCase()))).toList(),
      emit(Page2WorkingState(listOfUser: tempList))
    });
  }

  
}