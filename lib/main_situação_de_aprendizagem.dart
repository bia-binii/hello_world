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
        appBar: AppBar(title: Text("Meu cartão"), centerTitle: true),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 500,
                height: 600,
                color: const Color.fromARGB(255, 217, 218, 218),
                child: Center(
                  child: Container(
                    width: 350,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Banco SESI / SENAI",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 224, 223, 223),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.contactless,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              size: 25,
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 240),
                            Icon(
                              Icons.sim_card,
                              color: const Color.fromARGB(255, 241, 222, 82),
                              size: 40,),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "1234 5678 9012 3456",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 224, 223, 223),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                    ),

                    SizedBox(height: 8),

                    Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(
                              "Titular",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 201, 200, 200),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Bianca Letícia Bini",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 201, 200, 200),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                    ),

                    Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(
                              "Validade",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 201, 200, 200),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "12/30",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 201, 200, 200),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                    ),
                          ],
                    ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
