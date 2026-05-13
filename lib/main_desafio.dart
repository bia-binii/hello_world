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

  void curtir() {
    setState(() {
      curtidas++;
    });
  }


  void descurtir() {
    setState(() {
      if (curtidas > 0) {
      curtidas--;
      }
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

              Text("$curtidas curtidas", style: TextStyle(fontSize: 26)),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: curtir, 
                    child: const Text("👍 Curtir"),
                    ),

                  ElevatedButton(
                    onPressed: descurtir, 
                    child: const Text("👎 Descurtir"),
                    ),
                    
                ],
              )

            ],
          ), // Text
        ), // Center
      ); // Scaffold // MaterialApp
  }
}  
