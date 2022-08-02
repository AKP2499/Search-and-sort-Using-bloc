

import 'package:flutter/material.dart';
import 'package:todquest/controller/maincotroller.dart';
import 'package:todquest/screen/screen_1/page1.dart';
import 'package:provider/provider.dart';
import 'package:todquest/screen/screen_1/page2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider.value(value: MainController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.grey
        ),
        home: Page1(),
      ),
    );
  }
}
