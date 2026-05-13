// Exemplo de uso do SafeArea para proteger o conteúdo da barra de status
import 'package:flutter/material.dart';

void main() {
  runApp(SafeAreaExemple());
}
class SafeAreaExemple extends StatelessWidget {
  const SafeAreaExemple({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SafeArea",
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: const [
              Text("Aplicação Flutter", style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              Text("Conteúdo protegido da barra de status"),
            ],
          ),
        ),
      ),
    );
  }
}