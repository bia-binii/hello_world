
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
        appBar: AppBar(title: Text("Exemplo Row")),

        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home, size: 40), //40 => tamanho do ícone//

              SizedBox(width: 20), //Usado para criar um espaço entre os ícones//

              Icon(Icons.favorite, size: 40), //40 => tamanho do ícone//

              SizedBox(width: 20), //Usado para criar um espaço entre os ícones//

              Icon(Icons.settings, size: 40), //40 => tamanho do ícone//
            ],
          ),

        )
      ),
    );
  }
}
