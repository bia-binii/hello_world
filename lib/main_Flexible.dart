//Flexible (distribue os conteiners proporcionalmente, de acordo com o valor do flex)//
import 'package:flutter/material.dart';

void main() {
  runApp(FlexibleExemple());
}

class FlexibleExemple extends StatelessWidget {
  const FlexibleExemple({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo do Flexible',
      home: Scaffold(
        appBar:AppBar(
          title: const Text("Flexible"),
          ),
        body: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: 120,
                  color: Colors.red,
                  child: const Center(child: Text("1 parte")),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  height: 120,
                  color: Colors.blue,
                  child: const Center(child: Text("2 partes",
                  style: TextStyle(color: Colors.white),
                  ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}