import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/mascota.dart';

final supabase = Supabase.instance.client;//para la base de datos._.

class FormScreen extends StatefulWidget {
  final Mascota? mascota;
  final String? urlImagen;//para el url de la imagen que tenemos en storage

  FormScreen({super.key, this.mascota, this.urlImagen});

  @override
  State<FormScreen> createState() => _FormScreen();
}

class _FormScreen extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final tipoController = TextEditingController();
  final edadController = TextEditingController();
  final descripcionController = TextEditingController();

  String? urlImagen;

  @override
  void initState() {
    super.initState();
    urlImagen = widget.urlImagen;
  }

  Future<void> insertarMascota() async {
    try {
      await supabase.from('mascota').insert({
        'nombre': nombreController.text,
        'tipo': tipoController.text,
        'edad': edadController.text,
        'imagen': urlImagen,
        'descripcion': descripcionController.text,
      });
    } catch (e) {
      print('Error: $e');
      throw Exception('Error al guardar');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adoptar a ${widget.mascota?.nombre ?? ''}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                "Datos de la mascota",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              if (urlImagen != null)
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        urlImagen!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),

              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder(),
                ),
                validator: validarNombre,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: tipoController,
                decoration: const InputDecoration(
                  labelText: "Perro / Gato",
                  border: OutlineInputBorder(),
                ),
                validator: validarNombre,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: edadController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Edad",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: descripcionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Descripción",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 50,
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await insertarMascota();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Mascota registrada 🐾"),
                          ),
                        );
                       /* Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => Screen()),
                        );*/

                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Error al guardar"),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Registrar Mascota"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
////////////////
String? validarNombre(String? value) {
  if (value == null || value.isEmpty) {
    return "Ingrese un valor";
  }
  RegExp regex = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$');
  if (!regex.hasMatch(value)) {
    return "Solo se permiten letras";
  }
  return null;
}