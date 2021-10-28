import 'package:flutter/material.dart';
import 'package:student_sqflite_example/config/screen_routes.dart';
import 'package:student_sqflite_example/screens/add_screen.dart';
import 'package:student_sqflite_example/screens/home_screen.dart';
import 'package:student_sqflite_example/screens/update_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ScreenRoutes.homeRoute,
      routes: {
        ScreenRoutes.homeRoute : (context) => HomeScreen(),
        ScreenRoutes.addRoute : (context) => AddScreen(),
      },
    );
  }
}
