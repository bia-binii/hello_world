import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CarteiraDigital",
      home: CarteiraDigital(),
    );
  }
}

class CarteiraDigital extends StatelessWidget {
  const CarteiraDigital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carteira Digital"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          CartaoBanco(
            corCartao: Color.fromARGB(255, 229, 176, 43),
            imagePath: "assets/images/logo_bradesco.png",
            bandeira: "assets/images/bandeira_visa_gold.png",
            numero: "1234 5678 9012 3456",
            nome: "Bianca Letícia Bini",
            validade: "12/30",
          ),
          SizedBox(height: 20),
          CartaoBanco(
            corCartao: Color.fromARGB(255, 0, 2, 3),
            imagePath: "assets/images/logo_Santander.png",
            bandeira: "assets/images/bandeira_mastercard.png",
            numero: "1234 5678 9012 3456",
            nome: "Bianca Letícia Bini",
            validade: "12/30",
          ),
          SizedBox(height: 20),
          CartaoBanco(
            corCartao: Color.fromARGB(255, 254, 43, 143),
            imagePath: "assets/images/logo_flash.png",
            bandeira: "assets/images/bandeira_visa.png",
            numero: "1234 5678 9012 3456",
            nome: "Bianca Letícia Bini",
            validade: "12/30",
          ),
        ],
      ),
    );
  }
}

class CartaoBanco extends StatelessWidget {
  final Color corCartao;
  final String imagePath;
  final String numero;
  final String nome;
  final String validade;
  final String bandeira;

  const CartaoBanco({
    super.key,
    required this.corCartao,
    required this.imagePath,
    required this.numero,
    required this.nome,
    required this.validade,
    required this.bandeira,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),

        gradient: LinearGradient(
          colors: [
            corCartao.withOpacity(0.9),
            corCartao,
            corCartao.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        boxShadow: [
          BoxShadow(
            color: corCartao.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Stack(
        children: [

          //EFEITO DE BRILHO
          Positioned(
            top: -30,
            left: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(imagePath, width: 100, height: 60),
                    Image.asset(bandeira, width: 50, height: 50),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.sim_card, color: Colors.amber, size: 30),
                    Icon(Icons.contactless, color: Colors.white, size: 30),
                  ],
                ),

                Text(
                  numero,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Titular",
                          style: TextStyle(
                              color: Color.fromARGB(205, 255, 255, 255), fontSize: 12),
                        ),
                        Text(
                          nome,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Validade",
                          style: TextStyle(
                              color: Colors.white70, fontSize: 12),
                        ),
                        Text(
                          validade,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}