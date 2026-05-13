//Media Query
import 'package:flutter/material.dart';

void main() {
  runApp(MediaQueryExemple());
}
class MediaQueryExemple extends StatelessWidget {
  const MediaQueryExemple({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Exemplo do MediaQuery", home: MediaQueryScreen());
  }
}
class MediaQueryScreen extends StatelessWidget {
  const MediaQueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Media Query"),
      ),
      body: Center(
        child: Container(
          width: larguraTela * 0.8, 
          height: 120,
          color: Colors.green,
          child: const Center(
            child: Text(
              "Container responsivo",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),

    );
  }
}