import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/models/cartItem.dart';
import 'screens/home.dart';
import 'screens/initial.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final baseUrl = 'http://13.231.156.66/api';
  int _currentIndex = 0;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<CartItem> cartItems = [];

  final List<Widget> _screens = [
    Home(),
    Initial(),
  ];

  void _onItemTap(int index) {
    if (index == 3) {
      _showLoginDialog();
    } else if (index == 2) {
      _showCart();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  Future<void> getCartItems() async {
    try {
      String? customerId = await getCustomerId();
      final Uri url = Uri.parse('$baseUrl/cartItems/getByCustomer');
      final body = {
        'customer': customerId,
      };
      final header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer YOUR_API_KEY",
      };
      final response =
          await http.post(url, headers: header, body: jsonEncode(body));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          cartItems = (jsonData['rows'] as List)
              .map((eachCartItem) => CartItem.fromJson(eachCartItem))
              .toList();
        });
        print(cartItems);
      } else {
        print(response.statusCode == 200);
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> login() async {
    try {
      final body = {
        "phone": phoneController.text,
        "password": passwordController.text
      };
      final header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer YOUR_API_KEY",
      };
      final Uri url = Uri.parse('$baseUrl/customers/login');
      final response =
          await http.post(url, headers: header, body: jsonEncode(body));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final customerId = jsonData['customer'];
        saveCustomerId(customerId);
        phoneController.text = '';
        passwordController.text = '';
        Navigator.pop(context);
      } else {
        print(response.statusCode);
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> saveCustomerId(String customerId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('customerId', customerId);
  }

  Future<String?> getCustomerId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('customerId');
  }

  void _showCart() async  {
    await getCartItems();
    showBottomSheetCart();
  }

  void showBottomSheetCart() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            height: 800,
            child:  Column(
              children: [
                const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Cart',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    Column(
                      children: [
                        Text('$cartItems')
                      ],
                    )
              ],
            ),
          );
        });
  }

  void _showLoginDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
                TextField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: passwordController)
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                child: const Text('Login'),
              ),
            ],
          );
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
        key: _scaffoldKey,
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
              icon: Icon(Icons.add_shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.login),
              label: 'Login',
            ),
          ],
        ),
        // endDrawer: Drawer(
        //   child: Column(
        //   children: [
        //     const Center(
        //       child: Text('Cart' , style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold ),),
        //     ),
        //     Column(
        //       children: [
        //         Text('$cartItems')
        //       ],
        //     )
        //   ],
        // )),
      ),
    );
  }
}
