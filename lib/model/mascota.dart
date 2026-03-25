class Mascota {
  final int? id;
  final String nombre;
  final String tipo;
  final int edad;
  final String imagen;
  final String descripcion;

  Mascota({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.edad,
    required this.imagen,
    required this.descripcion,
  });

  factory Mascota.fromMap(Map<String, dynamic> map) {
    return Mascota(
      id: map['id'],
      nombre: map['nombre'],
      tipo: map['tipo'],
      edad: map['edad'],
      imagen: map['imagen'],
      descripcion: map['descripcion'],
    );
  }
}