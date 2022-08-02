
import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todquest/utils/session_manager.dart';

import '../data/user_model.dart';
class MainController extends ChangeNotifier{
  GlobalKey<FormState> accountFormKey = GlobalKey<FormState>();
  late SharedPreferences sharedPreferences;
  final List<User> userList = <User>[];
  void findPersonUsingIndexWhere(List<User> user,
      String personName,String userEmail) {
    // Find the index of person. If not found, index = -1
    final index = user.indexWhere((element) => element.name == personName || element.email== userEmail);
    if (index >= 0) {
      print('Using indexWhere: ${user[index]}');
    }
  }

  void searchNameAndEmail(String query)async{
    var savedUserList = await SessionManager.getUserList();
    final searchUser = savedUserList?.where((element) {
      final username= element.name.toLowerCase();
      final userEmail = element.email.toLowerCase();
      final input = query.toLowerCase();
      return username.contains(input)||userEmail.contains(input);
    }).toList();
    notifyListeners();
  }

  void addItemToList({required String name,required String email,required String dropDownValue}) async {
    User user = User(name:name,email: email,from:dropDownValue);
    var savedUserList = await SessionManager.getUserList();
    if(savedUserList != null) {
      savedUserList.add(user);
      SessionManager.setUserList(listOfUsers: savedUserList);
      notifyListeners();
    } else {
      userList.add(user);
      SessionManager.setUserList(listOfUsers: userList);
      notifyListeners();
    }
  }

}