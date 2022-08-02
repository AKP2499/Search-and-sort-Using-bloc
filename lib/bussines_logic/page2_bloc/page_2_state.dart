import '../../data/user_model.dart';

abstract class Page2State{}

class Page2InitialState extends Page2State{}

class Page2WorkingState extends Page2State{
  List<User> listOfUser;
  Page2WorkingState({required this.listOfUser});
}

class Page2LoadingState extends Page2State{}