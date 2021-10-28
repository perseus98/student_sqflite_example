import 'package:flutter/material.dart';
import 'package:student_sqflite_example/dao/student_dao.dart';
import 'package:student_sqflite_example/models/students_model.dart';
class UpdateScreen extends StatefulWidget {
  const UpdateScreen({ required this.studentModel,Key? key}) : super(key: key);
  final StudentModel studentModel;
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllerList = List<TextEditingController>.generate(
      3, (index) => TextEditingController());
  final _focusNodeList = List<FocusNode>.generate(3, (index) => FocusNode());

  @override
  void initState() {
    _controllerList[0].text = widget.studentModel.id.toString();
    _controllerList[1].text = widget.studentModel.name;
    _controllerList[2].text = widget.studentModel.age.toString();
    super.initState();
  }
  void processData() {
    if (_formKey.currentState!.validate()) {
      StudentDao.update(StudentModel(
          rollNo: int.parse(_controllerList[0].text),
          id: widget.studentModel.id,
          name: _controllerList[1].text,
          age: int.parse(_controllerList[2].text)));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("data received successfully")));
      // Navigator.pushNamed(context, ScreenRoutes.homeRoute);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Student Form Screen"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                focusNode: _focusNodeList[0],
                controller: _controllerList[0],
                decoration:
                InputDecoration(hintText: "Ex. 1", labelText: "Roll No :"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid value';
                  }
                  return null;
                },
                onFieldSubmitted: (value) => _focusNodeList[1].requestFocus(),
              ),
              TextFormField(
                focusNode: _focusNodeList[1],
                controller: _controllerList[1],
                decoration: InputDecoration(
                    hintText: "Ex. John Doe", labelText: "Name :"),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onFieldSubmitted: (value) => _focusNodeList[2].requestFocus(),
              ),
              TextFormField(
                focusNode: _focusNodeList[2],
                controller: _controllerList[2],
                decoration:
                InputDecoration(hintText: "Ex. 35", labelText: "Age :"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid value';
                  }
                  return null;
                },
                onFieldSubmitted: (value) => processData,
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: GestureDetector(
                  onTap: processData,
                  child: Container(
                    height: 40.0,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(30.0)),
                    alignment: Alignment.center,
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
