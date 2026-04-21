//imports
import 'package:flutter/material.dart';
import 'formscreen.dart';
import 'homescreen.dart';
import 'imagescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState() {
  super.initState();
  Future.delayed(Duration(seconds: 1),(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_){
          return HomeScreen();
        }));
  }
  );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF8E85FF)],
          begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.pets,
            size:100,
            color: Colors.white,
          ),
          SizedBox(height: 24),
          Text('Adopta y deja huella',
            style: TextStyle(fontSize: 28,
                fontWeight: FontWeight.bold,
            color: Colors.white
            ),
          ),
          SizedBox(height: 12,),
          Text('Dales una segunda oportunidad',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white
          ),
          ),
          SizedBox(height: 40),
          CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      ),
    ),
    );
  }
}