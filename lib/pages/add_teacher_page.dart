import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_hive/model/teacher.dart';

class AddTeacherPage extends StatefulWidget {
  const AddTeacherPage({super.key});

  @override
  State<AddTeacherPage> createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  final _key = GlobalKey<FormState>();
  int id=0; String? name; int age=0; String? subject;
  
  late Box<Teacher> teacherBox;

  @override
  void initState() {
    super.initState();
    teacherBox = Hive.box('teachers');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add teacher'),
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
          saveTeacher();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data Saved'),));
        }, 
        label: const Text('Save'),
        icon: const Icon(Icons.save),
      ),
      
    );
  }

  void saveTeacher(){
    final isValid = _key.currentState?.validate();

    if(isValid != null && isValid){
      _key.currentState?.save();
      teacherBox.add(
        Teacher(
          id: id, 
          name: name.toString(), 
          age: age, 
          subject: subject.toString()
        )
      );
    }
  }
}