import '../data/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {

  /// setters
  static void setUserList({required List<User> listOfUsers}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedListOfUsers = User.encode(listOfUsers);
   await prefs.setString("encodedListOfUsers", encodedListOfUsers);
  }
  ///getter
  static Future<List<User>?> getUserList()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userList =  prefs.getString('encodedListOfUsers');
    if(userList != null) {
      final List<User> users = User.decode(userList);
      return users;
    }
    return null;
  }

  // fetch and decode data

}