import 'package:flutter/material.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cart;
  final Function(Map<String, dynamic>) onRemove;

  const CartScreen({required this.cart, required this.onRemove, super.key});

  @override
  Widget build(BuildContext context) {
    double total = cart.fold(0, (sum, item) => sum + (item['quantity'] * 10.0)); // Precio ficticio

    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.shopping_cart),
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return CartItem(
                  item: item,
                  onRemove: () => onRemove(item), onRate: (double value) {  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${total.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirmar Compra'),
                          content: const Text('¿Estás seguro de que quieres proceder con la compra?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                // Añadir lógica para proceder con el pago
                              },
                              child: const Text('Sí'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent, // Color del botón
                  ),
                  child: const Text('Comprar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
