import 'package:flutter/material.dart';
import 'package:todo_app/UI/todo_screen.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ملاحظاتي",style:TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.white,
      ),
      body: TodoScreen(),
    );
  }

}