import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ContadorCurtidas());
  }
}

class ContadorCurtidas extends StatefulWidget {
  const ContadorCurtidas({super.key});

  @override
  _ContadorCurtidasState createState() => _ContadorCurtidasState();
}

class _ContadorCurtidasState extends State<ContadorCurtidas> {
  int curtidas = 0;

  void incrementar() {
    setState(() {
      curtidas++;
    });
  }

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Aplicativo de Curtidas"), centerTitle: true, 
),
    body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, color: Colors.redAccent, size:60),

              SizedBox(height: 20),

              Text("$curtidas curtidas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

              SizedBox(height: 20),

              ElevatedButton(
              onPressed: incrementar,
              child: Text("Curtir"),
              ),
              
            ],
          ), // Text
        ), // Center
      ); // Scaffold // MaterialApp
  }
}  
