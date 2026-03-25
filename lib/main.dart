//Imports
import 'package:flutter/material.dart';
import 'class/splashscreen.dart';
//main
void main(){
  runApp(AdopcionesApp());
}
//clase adopciones app
class AdopcionesApp extends StatelessWidget{
  AdopcionesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adopta',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0x009acd32)),
        fontFamily: 'Roboto',
      ),
      home: SplashScreen(),
    );
  }

}