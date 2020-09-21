import 'package:flutter/material.dart';

import 'UI/home.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "todo",
      home:Home() ,
    );
  }


}