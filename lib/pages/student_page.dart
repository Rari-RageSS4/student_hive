import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_hive/model/student.dart';
import 'package:student_hive/pages/add_student_page.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  late Box<Student> studentBox;

  @override
  void initState() {
    super.initState();
    studentBox = Hive.box('students');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: studentBox.length,
        itemBuilder: ((context, index){
          final student = studentBox.getAt(index) as Student;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(student.id.toString()),
                  Text(student.name.toString()),
                  Text(student.age.toString()),
                  Text(student.subject.toString())
                ],
              ),
            ),
          );
      })),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (_) => const AddStudentPage())
          );
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
      
    );
  }
}