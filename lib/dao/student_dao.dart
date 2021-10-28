import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_sqflite_example/database/student_db.dart';
import 'package:student_sqflite_example/main.dart';
import 'package:student_sqflite_example/models/students_model.dart';

class StudentDao extends StudentDB {
  static Future<List<StudentModel>> getAllData() async {
    final db = await StudentDB.database;
    final List<Map<String, dynamic>> maps = await db.query(StudentDB.studentTable);
    return List<StudentModel>.generate(maps.length, (i) {
      return StudentModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
        rollNo: maps[i]['rollNo'],
      );
    });
  }

  static Future<void> insert(StudentModel studentModel) async {
    final db = await StudentDB.database;
    await db.insert(
      StudentDB.studentTable,
      studentModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(StudentModel studentModel) async {
    final db = await StudentDB.database;
    await db.update(
      StudentDB.studentTable,
      studentModel.toMap(),
      where: 'id = ?',
      whereArgs: [studentModel.id],
    );
  }
  static Future<void> delete(int id) async {
    final db = await StudentDB.database;
    await db.delete(
      StudentDB.studentTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}