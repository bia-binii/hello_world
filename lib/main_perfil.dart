import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Meu Perfil"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 500,
                height: 600,
                color: Colors.white,
                child: Center(
                  child: Container(
                    width: 350,
                    height: 600,
                    padding: const EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 61, 65, 161),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        
                        Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),

                        Text(
                          "Bianca Letícia Bini",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),

                        Text(
                          'Desenvolvedora de Flutter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 30),

                        // Email
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'bianca.bini@aluno.senai.br',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        // Telefone (CORRIGIDO)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              '+55 19 99316-6488',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        // Localização
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Mococa-SP, Brasil',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        // Avaliação
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            SizedBox(width: 5),
                            Icon(Icons.star, color: Colors.amber),
                            SizedBox(width: 5),
                            Icon(Icons.star, color: Colors.amber),
                            SizedBox(width: 5),
                            Icon(Icons.star, color: Colors.amber),
                            SizedBox(width: 5),
                            Icon(Icons.star_half, color: Colors.amber),
                            SizedBox(width: 8),
                            Text(
                              '4.5',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        // Botão
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Editar Perfil'),
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