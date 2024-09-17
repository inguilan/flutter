import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Café Arábica',
      description: 'Café de alta calidad con notas afrutadas.',
      price: 10.0,
      rating: 4.5,
      imageUrl: 'https://example.com/arabica.jpg',
    ),
    // Agrega más productos aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cafiarandia'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        itemBuilder: (ctx, index) => ProductItem(product: products[index]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
