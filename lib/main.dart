import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_sqflite_example/dao/student_dao.dart';
import 'package:student_sqflite_example/database/student_db.dart';
import 'package:student_sqflite_example/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StudentDB.initDatabase();
  runApp(MyApp());
}
