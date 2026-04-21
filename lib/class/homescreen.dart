import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/mascota.dart';
import 'cards.dart';

class HomeScreen extends StatelessWidget{
  HomeScreen({super.key});

  Future<List<Mascota>> consultaMascotas(String estado) async{
    final supabase = Supabase.instance.client;
    final response = await supabase
      .from('mascota')
      .select();
    return (response as List)
        .map((item)=>Mascota.fromMap(item))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adopta una huella', style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: FutureBuilder<List<Mascota>>(
                    future: consultaMascotas('adopcion'),
                    builder: (context,snapshot){
                      if (snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      if (snapshot.hasError){
                        return Center(child: Text ('Error: ${snapshot.error}'),);
                      }
                      final mascotas =snapshot.data??[];
                      if (mascotas.isEmpty){
                        return Center(child: Text('No hay mascotas registradas'),);
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: mascotas.length,
                        itemBuilder: (context, index){
                          return Container(
                            width: 160,
                            margin: const EdgeInsets.only(right: 12),
                            child: MascotaCard(mascota: mascotas[index],),
                          );
                        },
                      );
                    }
                ),
              ),
              Text('mascotas extraviadas', style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 20,),
              Expanded(
                  child: FutureBuilder<List<Mascota>>(
                    future: consultaMascotas('Extraviado'),
                    builder: (context,snapshot){
                      if (snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      if (snapshot.hasError){
                        return Center(child: Text ('Error: ${snapshot.error}'),);
                      }
                      final mascotas =snapshot.data??[];
                      if (mascotas.isEmpty){
                        return Center(child: Text('No hay mascotas registradas'),);
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: mascotas.length,
                        itemBuilder: (context, index){
                          return Container(
                            width: 160,
                            margin: const EdgeInsets.only(right: 12),
                            child: MascotaCard(mascota: mascotas[index],),
                          );
                        },
                      );
                    },
                  )
              )
            ],
          )
        /* GridView.builder(
        itemCount: mascotas.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index){
          return MascotaCard(mascota: mascotas[index]);
        },

        ),*/
      ),
    );
  }
}