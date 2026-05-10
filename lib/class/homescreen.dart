import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/mascota.dart';
import 'cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final supabase = Supabase.instance.client;

  Future<List<Mascota>> consultaMascotas() async {
    final response = await supabase.from('mascota').select();
    return (response as List).map((item) => Mascota.fromMap(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Adopta una huella', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSeccion('Mascotas en adopción'),
              const SizedBox(height: 15),
              _buildCarrusel(),
              const SizedBox(height: 40),
              _buildSeccion('Mascotas extraviadas'),
              const SizedBox(height: 15),
              _buildCarrusel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeccion(String titulo) {
    return Text(
      titulo,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCarrusel() {
    return SizedBox(
      height: 350, // Altura amplia para que la imagen no se encoja
      child: FutureBuilder<List<Mascota>>(
        future: consultaMascotas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final mascotas = snapshot.data ?? [];

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(), // Rebote natural
            itemCount: mascotas.length,
            itemBuilder: (context, index) {
              return Container(
                width: 280, // Ancho mayor para que se vea bien en Web
                margin: const EdgeInsets.only(right: 20),
                child: MascotaCard(
                  mascota: mascotas[index],
                  onActionComplete: () => setState(() {}),
                ),
              );
            },
          );
        },
      ),
    );
  }
}