//Imports
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'class/splashscreen.dart';
//main
  Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://dbitagymespruogmrncs.supabase.co',
    anonKey: 'sb_publishable_IkxjjdN1FWmCPhECgQucVw_I5wVOKL9',
  );

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