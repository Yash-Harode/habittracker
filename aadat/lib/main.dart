import 'package:aadat/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //initialize the hive box
  await Hive.initFlutter();
  //open a box name of database
  await Hive.openBox("Habit_DataBase");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(primaryColor: Colors.green),
    );
  }
}
