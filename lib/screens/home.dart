import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/product.dart';
import 'package:intl/intl.dart';
import 'package:ecommerce/screens/productDetail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  List<Product> products = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute( builder: (context) => ProductDetail(product :products[index])));
                  },
                  child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Image.network(
                                    products[index].thumbnails?[0],
                                    fit: BoxFit.cover,
                                    height: 120),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(products[index].name),
                                    if (products[index].sellPrice == null)
                                      Column(
                                        children: [
                                          Text(
                                            CurrencyFormatter.formatTugrik(
                                                products[index].price),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    else
                                      Column(
                                        children: [
                                          Text(
                                              CurrencyFormatter.formatTugrik(
                                                  products[index].price),
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  decoration: TextDecoration
                                                      .lineThrough)),
                                          Text(
                                            CurrencyFormatter.formatTugrik(
                                                products[index].sellPrice),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ))));
            });
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }
  
  Future<void> fetchProducts() async {
    try {
      final url = 'http://13.231.156.66/api/products/list';

      final body = {'pages': 1, 'perPage': 10};

      final header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer YOUR_API_KEY",
      };

      final response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(body));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          products = (jsonData['rows'] as List)
              .map((eachProduct) => Product.fromJson(eachProduct))
              .toList();
          count = jsonData['count'];
        });
      } else {
        print(response.statusCode);
      }
    } catch (err) {
      print(err);
    }
  }
}

class CurrencyFormatter {
  static String formatTugrik(int? amount) {
    final format = NumberFormat.simpleCurrency(locale: 'mn_MN');
    return format.format(amount);
  }
}
