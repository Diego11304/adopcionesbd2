// Imports
import 'package:flutter/gestures.dart'; // <--- NECESARIO PARA WEB
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'class/splashscreen.dart';

// main
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://dbitagymespruogmrncs.supabase.co',
    anonKey: 'sb_publishable_IkxjjdN1FWmCPhECgQucVw_I5wVOKL9',
  );

  runApp(const AdopcionesApp());
}

// clase adopciones app
class AdopcionesApp extends StatelessWidget {
  const AdopcionesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adopta',

      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF9ACD32)),
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}