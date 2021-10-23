import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_sqflite_example/dao/student_dao.dart';
import 'package:student_sqflite_example/models/students_model.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController rollNoTextEditingController = TextEditingController();

  void processData(){
    if(_formKey.currentState!.validate()){
      // StudentDao.insert(StudentModel(rollNo: rollNo, id: id, name: name, age: age))
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Student Form Screen"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                controller: rollNoTextEditingController,
                decoration: InputDecoration(
                    hintText: "Ex. 1", labelText: "Roll No :"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: nameTextEditingController,
                decoration: InputDecoration(
                    hintText: "Ex. John Doe", labelText: "Name :"),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: ageTextEditingController,
                decoration: InputDecoration(
                    hintText: "Ex. 35", labelText: "Age :"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid value';
                  }
                  return null;
                },
              ),
             Padding(padding: EdgeInsets.only(top: 50.0), child: GestureDetector(
               onTap: processData,
               child: Container(
                 height: 40.0,
                 width: 150,
                 decoration: BoxDecoration(
                     color: Colors.deepPurple,
                     borderRadius: BorderRadius.circular(30.0)
                 ),
                 alignment: Alignment.center,
                 child: Text("Submit",style: TextStyle(color: Colors.white),),
               ),
             ),)


            ],
          ),
        ),
      ),
    );
  }
}
