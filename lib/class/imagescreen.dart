import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageScreen extends StatefulWidget{
  const ImageScreen ({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ImageScreenState();
  }
  
}

class _ImageScreenState extends State<ImageScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  Uint8List? _imageBytes;
  final supabase = Supabase.instance.client;

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) return;
    final bytes = await image.readAsBytes();
    setState(() {
      _imageFile = image;
      _imageBytes = bytes;
    });
  }

  Future<void> uploadFile() async {
    if (_imageFile == null || _imageBytes == null) return;
    final fileName = '${DateTime
        .now()
        .microsecondsSinceEpoch}_${_imageFile!.name}';
    final String path = await supabase.storage
        .from('imagenes_mascota')
        .uploadBinary(
        'imamascota/$fileName',
        _imageBytes!,
        fileOptions: const FileOptions(
            cacheControl: '3600',
            upsert: false
        )
    );
    final publicUrl =supabase.storage
        .from('imagenes_mascota')
    .getPublicUrl('imamascota/$fileName');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('imagen almacenada'))
    );

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) {return FormScreen(urlImage: publicUrl);},
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('registrar mascota'),),
      body: SafeArea(
          child: Column(
            children: [
              Flexible(
                  child: Center(
                    child: _imageBytes==null
                    ? const Text('no hay imagen seleccionada')
                        :ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12),
                      child: Image.memory(_imageBytes!,fit: BoxFit.contain,),
                    )
                    ,
                  )
              )
            ],
          )
      )
    );
  }
  }
}