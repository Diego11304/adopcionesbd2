import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/mascota.dart';
import 'homescreen.dart';

final supabase = Supabase.instance.client;

class FormScreen extends StatefulWidget {
  final Mascota? mascota;
  final String? urlImagen;

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

    if (widget.mascota != null) {
      nombreController.text = widget.mascota!.nombre;
      tipoController.text = widget.mascota!.tipo;
      edadController.text = widget.mascota!.edad.toString();
      descripcionController.text = widget.mascota!.descripcion;
      // Si no viene una url nueva de ImageScreen, usamos la que ya tenía
      urlImagen ??= widget.mascota!.imagen;
    }
  }

  Future<void> guardarDatos() async {
    final datos = {
      'nombre': nombreController.text,
      'tipo': tipoController.text,
      'edad': int.tryParse(edadController.text) ?? 0,
      'imagen': urlImagen,
      'descripcion': descripcionController.text,
    };

    try {
      if (widget.mascota == null) {
        // INSERTAR NUEVO
        await supabase.from('mascota').insert(datos);
      } else {
        // ACTUALIZAR EXISTENTE (Usamos eq para filtrar por ID)
        await supabase
            .from('mascota')
            .update(datos)
            .eq('id', widget.mascota!.id!); // El '!' asegura que el ID no es nulo
      }
    } catch (e) {
      print('Error en Supabase: $e');
      throw Exception('Error al procesar la solicitud');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mascota == null ? "Registrar Mascota" : "Editar a ${widget.mascota!.nombre}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                widget.mascota == null ? "Datos de la mascota" : "Actualizar información",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),

              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: "Nombre", border: OutlineInputBorder()),
                validator: validarNombre,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: tipoController,
                decoration: const InputDecoration(labelText: "Perro / Gato", border: OutlineInputBorder()),
                validator: validarNombre,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: edadController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Edad", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: descripcionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Descripción", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 30),

              SizedBox(
                height: 50,
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await guardarDatos();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(widget.mascota == null ? "Mascota registrada 🐾" : "Información actualizada ✨")),
                          );
                          // Volvemos al Home
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => HomeScreen()),
                                (route) => false,
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Error al guardar")),
                          );
                        }
                      }
                    }
                  },
                  child: Text(widget.mascota == null ? "Registrar Mascota" : "Guardar Cambios"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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