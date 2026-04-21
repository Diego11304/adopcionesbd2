import 'package:flutter/material.dart';
import '../model/mascota.dart';

class MascotaCard extends StatelessWidget {
  final Mascota mascota;

  const MascotaCard({super.key, required this.mascota});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: (){

      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: ClipRRect(
              borderRadius: .vertical(top: Radius.circular(20)),
              child: Image.network(
                mascota.imagen,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, StackTrace)=>Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
            ),
            Padding(padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mascota.nombre, style: Theme.of(context).textTheme.titleMedium?.copyWith
                    (fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('${mascota.tipo} ${mascota.edad} años')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}