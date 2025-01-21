import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return (
        Text("Products page")
    );
  }
}