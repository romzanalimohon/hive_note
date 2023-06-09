import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_tutorial/hive_home.dart';
import 'package:hive_tutorial/home_screen.dart';
import 'package:hive_tutorial/models/notes_model.dart';
import 'package:path_provider/path_provider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes');

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: HomeScreen(),
      home: HiveHome(),
    );
  }
}
