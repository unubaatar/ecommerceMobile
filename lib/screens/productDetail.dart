import 'package:ecommerce/models/productVariant.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/models/product.dart';
import 'package:intl/intl.dart';
import 'package:ecommerce/models/product.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProductDetail> {
  late List<bool> _selectedVariants;
  late ProductVariant selectedVariant;

  @override
  void initState() {
    super.initState();
    _selectedVariants =
        List.generate(widget.product.variants!.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return MaterialApp(
        title: 'Ecommerce',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Ecommerce"),
              centerTitle: true,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            body: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: Center(
                        child: Image.network(
                          product.thumbnails?[0],
                          width: 300,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.network(
                                  '${product.brand?.image}',
                                  width: 72,
                                ),
                                Text(
                                  '${product.brand?.name}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Text(
                            product.name,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Text(
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                            ),
                          ),
                          ToggleButtons(
                            isSelected: _selectedVariants,
                            children: widget.product.variants!.map((variant) {
                              return ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedVariant = variant;
                                    });
                                  },
                                  child: Text(variant.name));
                            }).toList(),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                          ),
                          Text('${selectedVariant.name}')
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  left: 5,
                  top: 5,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SizedBox(
                        height: 100,
                        child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: product.sellPrice != null
                                        ? [
                                            Text(
                                              CurrencyFormatter.formatTugrik(
                                                  product.price),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blueGrey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                            Text(
                                              CurrencyFormatter.formatTugrik(
                                                  product.sellPrice),
                                              style:
                                                  const TextStyle(fontSize: 24),
                                            ),
                                          ]
                                        : [
                                            Text(
                                              CurrencyFormatter.formatTugrik(
                                                  product.price),
                                              style:
                                                  const TextStyle(fontSize: 24),
                                            ),
                                          ],
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  const Color.fromARGB(
                                                      255, 199, 44, 83)),
                                          foregroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.white)),
                                      onPressed: () {},
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.shopping_cart,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Add to cart',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            ))))
              ],
            )));
  }
}

class CurrencyFormatter {
  static String formatTugrik(int? amount) {
    final format = NumberFormat.simpleCurrency(locale: 'mn_MN');
    return format.format(amount);
  }
}
