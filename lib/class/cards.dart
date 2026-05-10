import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/mascota.dart';
import 'formscreen.dart';

class MascotaCard extends StatelessWidget {
  final Mascota mascota;
  final VoidCallback? onActionComplete;

  const MascotaCard({super.key, required this.mascota, this.onActionComplete});

  Future<void> _eliminarMascota(BuildContext context) async {
    final supabase = Supabase.instance.client;
    try {
      // FIX: Aseguramos que el ID no sea nulo con '!'
      await supabase.from('mascota').delete().eq('id', mascota.id!);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Mascota eliminada 🗑️")),
        );
        if (onActionComplete != null) onActionComplete!();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al eliminar: $e")),
        );
      }
    }
  }

  void _confirmarBorrado(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmar"),
        content: Text("¿Deseas eliminar a ${mascota.nombre}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                _eliminarMascota(context);
              },
              child: const Text("Eliminar", style: TextStyle(color: Colors.red))
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.network(
                    mascota.imagen,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => const Center(child: Icon(Icons.pets)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mascota.nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("${mascota.tipo} • ${mascota.edad} años"),
                  ],
                ),
              ),
            ],
          ),
          // Botones de acción
          Positioned(
            top: 10,
            right: 10,
            child: Column(
              children: [
                _ActionButton(
                  icon: Icons.edit,
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FormScreen(mascota: mascota, urlImagen: mascota.imagen),
                      ),
                    ).then((_) => onActionComplete?.call());
                  },
                ),
                const SizedBox(height: 8),
                _ActionButton(
                  icon: Icons.delete,
                  color: Colors.red,
                  onPressed: () => _confirmarBorrado(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  const _ActionButton({required this.icon, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white70, shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(icon, size: 20, color: color),
        onPressed: onPressed,
      ),
    );
  }
}