import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CartItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onRemove;
  final ValueChanged<double> onRate; // Añadido para actualizar la calificación

  const CartItem({
    required this.item,
    required this.onRemove,
    required this.onRate, // Añadido
    super.key,
  });

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        double currentRating = item['rating'].toDouble();
        return AlertDialog(
          title: const Text('Calificar Producto'),
          content: RatingBar.builder(
            initialRating: currentRating,
            minRating: 1,
            itemSize: 40,
            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {
              onRate(rating);
              Navigator.of(context).pop(); // Cierra el diálogo después de la calificación
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cantidad: ${item['quantity']}'),
            const SizedBox(height: 8),
            const Text('Precio por unidad: \$10.00'), // Precio ficticio
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _showRatingDialog(context),
              child: Row(
                children: [
                  const Text('Calificación:'),
                  const SizedBox(width: 8),
                  RatingBarIndicator(
                    rating: item['rating'].toDouble(),
                    itemCount: 5,
                    itemSize: 20,
                    physics: const BouncingScrollPhysics(), // Solo visualización
                    itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.red),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
