import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hive database'),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: Hive.openBox('midoriya'),
              builder: (context, snapshot){
                return ListTile(
                  title: Text(snapshot.data!.get('name').toString()),
                  subtitle: Text(snapshot.data!.get('age').toString()),
                  trailing: IconButton(
                    onPressed: (){
                      snapshot.data!.delete('name');
                     // snapshot.data!.put('age', 19);
                      setState(() {

                      });
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
                // return Column(
                //   children: [
                //     Text(snapshot.data!.get('name').toString()),
                //     Text(snapshot.data!.get('age').toString()),
                //     Text(snapshot.data!.get('details').toString()),
                //   ],
                // );
              }),
          FutureBuilder(
              future: Hive.openBox('course'), builder: (context, snapshot) {
                return ListTile(
                  title: Text(snapshot.data!.get('subject').toString()),
                );
          })
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          var box = await Hive.openBox('midoriya');
          var box2 = await Hive.openBox('course');
          box2.put('subject', 'physics');
          box.put('name', 'midoriya izuku');
          box.put('age', 16);
          box.put('details', {
            'pro': 'hero',
            'class': 'A'
          });

          print(box.get('name'));
          print(box.get('age'));
          print(box.get('details'));
          print(box.get('details')['class']);
          print(box.get('subject'));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
