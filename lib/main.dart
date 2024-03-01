import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_hive/model/student.dart';
import 'package:student_hive/model/teacher.dart';
import 'package:student_hive/pages/bank.dart';
import 'package:student_hive/pages/home.dart';
import 'package:student_hive/pages/student_page.dart';
import 'package:student_hive/pages/teacher_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.initFlutter('hive_db');

  Hive.registerAdapter<Student>(StudentAdapter());
  Hive.registerAdapter<Teacher>(TeacherAdapter());
  await Hive.openBox<Student>('students');
  await Hive.openBox<Teacher>('teachers');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  final pages = [
    const Home(),
    const StudentPage(),
    const TeacherPage(),
    const Bank()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Hive'),
        ),
        body: pages[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          backgroundColor: Colors.teal,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.tealAccent,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          onTap: (value){
            setState(() {
              index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Student'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Teacher'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: 'Bank'
            )
          ]
        ),
      ),
    );
    
  }
}