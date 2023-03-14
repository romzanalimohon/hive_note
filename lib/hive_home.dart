
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_tutorial/boxes/boxses.dart';
import 'package:hive_tutorial/models/notes_model.dart';

class HiveHome extends StatefulWidget {
  const HiveHome({Key? key}) : super(key: key);

  @override
  State<HiveHome> createState() => _HiveHomeState();
}

class _HiveHomeState extends State<HiveHome> {
  
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hive database'),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _){
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(data[index].title.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                            Spacer(),
                            InkWell(
                                onTap: (){
                                  _editMyDialog(data[index], data[index].title.toString(), data[index].description.toString());
                                },
                                child: Icon(Icons.edit)),
                            SizedBox(width: 13,),
                            InkWell(
                                onTap: (){
                                  delete(data[index]);
                                },
                                child: Icon(Icons.delete, color: Colors.red,))
                          ],
                        ),
                        Text(data[index].description.toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300))
                      ],
                    ),
                  ),
                );
              }
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          _showMyDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }


  void delete(NotesModel notesModel) async{
    await notesModel.delete();
  }



  ///for update data
  Future<void> _editMyDialog(NotesModel notesModel, String title, String description) async{
    titleController.text = title;
    descriptionController.text = description;
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('edit notes'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText: 'enter title',
                        border: OutlineInputBorder()
                    ),
                  ),

                  SizedBox(height: 10,),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        hintText: 'enter description',
                        border: OutlineInputBorder()
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('cancel')),
              TextButton(
                  onPressed: () async{

                    notesModel.title = titleController.text.toString();
                    notesModel.description = descriptionController.text.toString();
                    notesModel.save();
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child:Text('edit')
              ),
            ],
          );
        }
    );
  }




  Future<void> _showMyDialog() async{
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('add notes'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'enter title',
                      border: OutlineInputBorder()
                    ),
                  ),

                  SizedBox(height: 10,),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        hintText: 'enter description',
                        border: OutlineInputBorder()
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('cancel')),
              TextButton(
                  onPressed: (){
                    final data = NotesModel(title: titleController.text, description: descriptionController.text);
                    final box = Boxes.getData();
                    box.add(data);
                    //data.save();
                    print(box);
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child:Text('add')
              ),
            ],
          );
        }
    );
  }

}
