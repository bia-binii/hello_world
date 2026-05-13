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
        backgroundColor: const Color(0xFFF2F2F2),
        appBar: AppBar(title: const Text("Meus cartões"), centerTitle: true),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 15),
          children: [
            Center(
              child: cartao(
                imagem: Image.asset(("assets/images/logo_NU.png"),
                  width: 80,
                  height: 70,
                ),
                numero: "1234 5678 9012 3456",
                titular: "Bianca Letícia Bini",
                validade: "12/30",
                cor: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 54, 16, 84),
                    Color.fromARGB(255, 166, 71, 255),
                    Color.fromARGB(255, 54, 16, 84),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: cartao(
                imagem: Image.asset(("assets/images/logo_bradesco.png"),
                  width: 120,
                  height: 90,
                ),
                numero: "1234 5678 9012 3456",
                titular: "Bianca Letícia Bini",
                validade: "12/30",
                cor: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 116, 19, 19),
                    Color.fromARGB(255, 255, 61, 61),
                    Color.fromARGB(255, 116, 19, 19),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: cartao(
                imagem: Image.asset(("assets/images/logo_inter.png"),
                  width: 80,
                  height: 70,
                ),
                numero: "1234 5678 9012 3456",
                titular: "Bianca Letícia Bini",
                validade: "12/30",
                cor: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 171, 64, 2),
                    Color.fromARGB(255, 245, 147, 104),
                    Color.fromARGB(255, 171, 64, 2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget cartao({
  required Image imagem,
  required String numero,
  required String titular,
  required String validade,
  required LinearGradient cor,
}) {
  return Container(
    width: 350,
    height: 200,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: cor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 4)),
      ],
    ),
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOPO
            imagem,

            Text(
              numero,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Titular",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    Text(
                      titular,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Validade",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    Text(
                      validade,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        const Positioned(
          top: 0,
          right: 0,
          child: Column(
            children: [
              Icon(Icons.contactless, color: Colors.white, size: 25),
              SizedBox(height: 10),
              Icon(
                Icons.sim_card,
                color: Color.fromARGB(255, 241, 222, 82),
                size: 40,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
