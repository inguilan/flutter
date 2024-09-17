import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(product.imageUrl, fit: BoxFit.cover),
          Text(product.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('\$${product.price.toStringAsFixed(2)}', style: TextStyle(color: Colors.grey)),
          Text(product.description, maxLines: 2, overflow: TextOverflow.ellipsis),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.star),
                color: Colors.amber,
                onPressed: () {}, // Lógica para calificar
              ),
              IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () {}, // Lógica para añadir al carrito
              ),
            ],
          ),
        ],
      ),
    );
  }
}
