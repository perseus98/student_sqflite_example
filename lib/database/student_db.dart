import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_sqflite_example/main.dart';
class StudentDB {
  static late final database;
  static String studentTable = 'students';
  static initDatabase() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'student_db.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $studentTable (id INTEGER AUTO_INCREMENT PRIMARY KEY, name TEXT, age INTEGER, rollNo INTEGER)',
        );
      },
      version: 1,
    );
  }
}