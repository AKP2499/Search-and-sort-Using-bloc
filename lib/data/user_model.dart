import 'dart:convert';

class User{
  String name,email,from;

  User({required this.name,required this.email,required this.from});

  User.fromJson(Map<String,dynamic>json):name=json['name'],email=json['email'],from=json['from'];

  static Map<String,dynamic> toMap(User users)=>{
    'name': users.name,
    'email': users.email,
    'from': users.from,
  };
  static String encode(List<User> users)=>jsonEncode(users.map<Map<String, dynamic>>((users) => User.toMap(users)).toList());

  static List<User>decode(String users) =>
      (json.decode(users) as List<dynamic>)
          .map<User>((item) => User.fromJson(item))
          .toList();

}