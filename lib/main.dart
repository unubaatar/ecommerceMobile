import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/initial.dart';
import 'screens/productDetail.dart';
import 'screens/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;


  final List<Widget> _screens = [
    Home(),    
    Initial(),        
    Products(),      
  ];

  void _onItemTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Ecommerce"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: _screens[_currentIndex], 
        bottomNavigationBar: BottomNavigationBar( 
          selectedItemColor: Colors.black, 
          unselectedItemColor: Colors.grey,  
          currentIndex: _currentIndex,  
          onTap: _onItemTap,  
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home', 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search', 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Products',  
            ),
          ],
        ),
      ),
    );
  }
}