import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return (
        Text("Product detail page")
    );
  }
}