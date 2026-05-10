import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'imagescreen.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ImageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateFromDrawer(int index) {
    Navigator.pop(context);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADOPCIONES"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Diego Arevalo"),
              accountEmail: Text("22041329@itdurango.com"),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => _navigateFromDrawer(0),
            ),

            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Image"),
              onTap: () => _navigateFromDrawer(1),
            ),
            /*ListTile(
              leading: const Icon(Icons.preview),
              title: const Text("Preview"),
              onTap: () => _navigateFromDrawer(0),
            ),*/
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: "Imágenes",
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.preview),
            label: "Preview",
          ),*/
        ],
      ),
    );
  }
}