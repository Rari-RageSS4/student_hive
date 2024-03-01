import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_hive/model/student.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _key = GlobalKey<FormState>();
  int id=0; String? name; int age=0; String? subject;
  late Box<Student> studentBox;

  @override
  void initState() {
    super.initState();
    studentBox = Hive.box('students');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'id',
                        helperText: 'Input your Id',
                      ),
                      onSaved: (value){
                        id = int.parse(value.toString());
                      },
                    ),
                
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        helperText: 'Input your Name',
                      ),
                      onSaved: (value){
                        name = value.toString();
                      },
                    ),
                
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        helperText: 'Input your Age',
                      ),
                      onSaved: (value){
                        age = int.parse(value.toString());
                      },
                    ),
                
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'subject',
                        helperText: 'Input your subject',
                      ),
                      onSaved: (value){
                        subject = value.toString();
                      },
                    ),
                  ],
                ),
              ),
              
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          saveStudent();
        }, 
        label: const Text('Save'),
        icon: const Icon(Icons.save),
      ),
      
    );
  }

  void saveStudent(){
    final isValid = _key.currentState?.validate();

    if(isValid != null && isValid){
      _key.currentState?.save();
      studentBox.add(
        Student(
          id: id, 
          name: name.toString(), 
          age: age, 
          subject: subject.toString()
        )
      );
    }
  }
}