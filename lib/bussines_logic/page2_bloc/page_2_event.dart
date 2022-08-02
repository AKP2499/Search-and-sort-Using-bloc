
import '../../data/user_model.dart';

abstract class Page2Event{}

class Page2InitialEvent extends Page2Event{}

class Page2SearchEvent extends Page2Event{
  final String value;
  final List<User> listOfUsers;
  Page2SearchEvent({required this.listOfUsers,required this.value});
}
class Page2FilterEvent extends Page2Event{
  final String value;
  final List<User> listOfUsers;
  Page2FilterEvent({required this.listOfUsers,required this.value});
}

