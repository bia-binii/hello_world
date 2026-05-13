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
        appBar: AppBar(title: Text("Minha Tela")),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.apple, size:60),

              SizedBox(height: 20),

              Text("D.S. é o melhor curso do SESI?" ,
               style: TextStyle (
               fontSize: 22,
               color: Colors.blueAccent,
              fontWeight: FontWeight.bold
               ),
              ),
              
              ElevatedButton(
                onPressed: () {
                  print("Usuário clicou no botão!");
                },
                child: Text("Curtir"),
                ),
            ],
          ), // Text
        ), // Center
      ), // Scaffold
    ); // MaterialApp
  }
}