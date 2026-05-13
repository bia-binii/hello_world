import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Exemplo Container")),

        body: Container(
          width: 200,
          height: 100,
          color: Colors.pink,
          child: Center(
            child: Text("Olá Bianca!", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),            
          ),
        ),
      ),
    );
  }
}
