import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_sqflite_example/config/screen_routes.dart';
import 'package:student_sqflite_example/dao/student_dao.dart';
import 'package:student_sqflite_example/models/students_model.dart';
import 'package:student_sqflite_example/screens/update_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {});
          return Future<void>.delayed(Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Student Database Management System"),
            ),
            SliverFillRemaining(
              child: Container(
                decoration: BoxDecoration(
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
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.pushNamed(context, ScreenRoutes.addRoute);
            setState(() {});
          },
          label: Text("Add Data")),
    );
  }

  Widget studentDetailWidget(StudentModel studentModel) {
    return Container(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(child: Text(studentModel.id.toString())),
          Flexible(child: Text(studentModel.name)),
          Flexible(child: Text(studentModel.age.toString())),
          Flexible(child: Text(studentModel.rollNo.toString())),
          Flexible(
              child: IconButton(
            onPressed: () async {
              await StudentDao.delete(studentModel.id ?? 0);
              setState(() {});
            },
            icon: Icon(Icons.delete_forever_outlined),
          )),
          Flexible(
              child: IconButton(
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UpdateScreen(studentModel: studentModel)));
              setState(() {});
            },
            icon: Icon(Icons.edit_outlined),
          )),
        ],
      ),
    );
  }
}
