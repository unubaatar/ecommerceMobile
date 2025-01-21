import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/product.dart';

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
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Container(
                child: Card(
                    margin: EdgeInsets.all(8.0),
                    child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image.network(
                                      products[index].thumbnails![0],
                                      fit: BoxFit.cover,
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('${products[index].name}'),
                                        Text('${products[index].brand?.name}'),
                                        Text(
                                            '${products[index].category?.name}'),
                                      ],
                                    )),
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.red),
                                foregroundColor:
                                    WidgetStateProperty.all(Colors.white),
                              ),
                              onPressed: test,
                              child: Text('Add to cart'),
                            )
                          ],
                        ))),
              );
            },
          ));
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void test() {
    print("test");
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
