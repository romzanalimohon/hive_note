



import 'package:hive/hive.dart';
import 'package:hive_tutorial/models/notes_model.dart';

class Boxes{
  static Box<NotesModel> getData() => Hive.box<NotesModel>('notes');
}