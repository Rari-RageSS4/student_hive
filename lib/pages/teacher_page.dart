import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_hive/model/teacher.dart';
import 'package:student_hive/pages/add_teacher_page.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  late Box<Teacher> teacherBox;

  @override
  void initState() {
    super.initState();
    teacherBox = Hive.box('teachers');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: teacherBox.listenable(), 
        builder: (context,box,child){
          return ListView.builder(
        itemCount: teacherBox.length,
        itemBuilder: ((context, index){
          final student = teacherBox.getAt(index) as Teacher;
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
      }));
        }
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (_) => const AddTeacherPage())
          );
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
      
    );
  }
}