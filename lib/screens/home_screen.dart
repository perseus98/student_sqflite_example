import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_sqflite_example/config/screen_routes.dart';
import 'package:student_sqflite_example/dao/student_dao.dart';
import 'package:student_sqflite_example/models/students_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Student Database Management System"),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: false,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purpleAccent,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30.0),
                    topRight: const Radius.circular(30.0)),
              ),
              child: FutureBuilder<List<StudentModel>>(
                  future: StudentDao.getAllData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error : " + snapshot.error.toString()),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data!.length < 1) {
                        return Center(
                          child: Text("No data record found"),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return studentDetailWidget(snapshot.data![index]);
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.pushNamed(context, ScreenRoutes.addRoute),
          label: Text("Add Data")),
    );
  }

  Widget studentDetailWidget(StudentModel studentModel) {
    return Container(
      height: 100.0,
      child: Column(
        children: [
          Row(
            children: [
              Flexible(child: Text(studentModel.id.toString())),
              Flexible(child: Text(studentModel.name))
            ],
          ),
          Row(
            children: [
              Flexible(child: Text(studentModel.age.toString())),
              Flexible(child: Text(studentModel.rollNo.toString()))
            ],
          )
        ],
      ),
    );
  }
}
