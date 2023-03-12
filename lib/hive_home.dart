import 'package:flutter/material.dart';

class HiveHome extends StatefulWidget {
  const HiveHome({Key? key}) : super(key: key);

  @override
  State<HiveHome> createState() => _HiveHomeState();
}

class _HiveHomeState extends State<HiveHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hive database'),
      ),
      body: Column(
        children: [

        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
