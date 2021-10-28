class StudentModel {
  final int? id;
  final String name;
  final int age;
  final int rollNo;

  StudentModel({
    required this.rollNo,
    required this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'rollNo': rollNo,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Student {id: $id, name: $name, age: $age, rollNo: $rollNo}';
  }
}

