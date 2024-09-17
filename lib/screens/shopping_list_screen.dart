import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> cart = [];
  List<Map<String, dynamic>> favorites = [];
  List<Map<String, dynamic>> filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();
  bool _sortByQuantity = false;
  int _minQuantity = 1;

  @override
  void initState() {
    super.initState();
    _initializeProducts();
    _applyFilters();
  }

  void _initializeProducts() {
products = [
  {'name': 'Café Arabica', 'quantity': 10, 'rating': 4.5, 'favorite': false, 'description': 'Café de alta calidad con notas afrutadas.', 'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSb1RJd8G65m7kLtmpptQkAgDbQHAEyKLt8Q&s'},
  {'name': 'Café Robusta', 'quantity': 5, 'rating': 4.0, 'favorite': false, 'description': 'Café con un sabor más fuerte y cuerpo.', 'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1TW8wliTnxRbj4u6ZVloTMzIjr5J_PB7SsA&s'},
  {'name': 'Café de Colombia', 'quantity': 8, 'rating': 4.7, 'favorite': false, 'description': 'Café colombiano con un perfil de sabor equilibrado.', 'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1EhoBKwKL6i8djLQp6o67bpKD5BlaF5F9ag&s'},
  {'name': 'Café de Brasil', 'quantity': 12, 'rating': 4.3, 'favorite': false, 'description': 'Café con un toque dulce y notas de nuez.', 'imageUrl': 'https://st2.depositphotos.com/4235711/7707/i/450/depositphotos_77072419-stock-photo-still-life-coffee-wtih-text.jpg'},
  {'name': 'Café Expreso', 'quantity': 6, 'rating': 4.6, 'favorite': false, 'description': 'Café concentrado con un sabor intenso.', 'imageUrl': 'https://plus.unsplash.com/premium_photo-1675435644687-562e8042b9db?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2FmJUMzJUE5JTIwZXNwcmVzc298ZW58MHx8MHx8fDA%3D'},
  {'name': 'Café Descafeinado', 'quantity': 7, 'rating': 4.2, 'favorite': false, 'description': 'Café sin cafeína con un sabor suave.', 'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8cC-3WULDRwriClyqVfg1ZH0143lS476adg&s'},
];

    _applyFilters();
  }

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      final existingProduct = cart.firstWhere(
        (item) => item['name'] == product['name'],
        orElse: () => {},
      );

      if (existingProduct.isEmpty) {
        cart.add({...product, 'quantity': 1});
      } else {
        final index = cart.indexWhere((item) => item['name'] == product['name']);
        cart[index]['quantity'] += 1;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product['name']} añadido al carrito'),
        ),
      );
    });
  }

  void _removeFromCart(Map<String, dynamic> product) {
    setState(() {
      cart.removeWhere((item) => item['name'] == product['name']);
    });
  }

  void _toggleFavorite(Map<String, dynamic> product) {
    setState(() {
      final index = products.indexWhere((item) => item['name'] == product['name']);
      products[index]['favorite'] = !products[index]['favorite'];
      products.sort((a, b) {
        if (a['favorite'] == b['favorite']) {
          return a['name'].compareTo(b['name']);
        }
        return a['favorite'] ? -1 : 1;
      });
      _applyFilters();
    });
  }

  void _rateProduct(int index, double rating) {
    setState(() {
      products[index]['rating'] = rating;
    });
  }

  void _applyFilters() {
    final searchQuery = _searchController.text.toLowerCase();
    final minQuantity = _minQuantity;

    filteredProducts = products
        .where((product) => product['name'].toLowerCase().contains(searchQuery))
        .where((product) => product['quantity'] >= minQuantity)
        .toList();

    if (_sortByQuantity) {
      filteredProducts.sort((a, b) => b['quantity'].compareTo(a['quantity']));
    } else {
      filteredProducts.sort((a, b) => a['name'].compareTo(b['name']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palmicafé', textAlign: TextAlign.center),
        actions: [
          badges.Badge(
            badgeContent: Text(
              cart.length.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.orange),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CartScreen(
                    cart: cart,
                    onRemove: _removeFromCart,
                  ),
                ));
              },
              tooltip: 'Ver Carrito',
            ),
          ),
          IconButton(
            icon: Icon(_sortByQuantity ? Icons.sort_by_alpha : Icons.sort),
            onPressed: () {
              setState(() {
                _sortByQuantity = !_sortByQuantity;
                _applyFilters();
              });
            },
            tooltip: _sortByQuantity ? 'Ordenar por Nombre' : 'Ordenar por Cantidad',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _applyFilters();
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.brown[50],
                      labelText: 'Buscar Producto',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 120,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.brown[50],
                      labelText: 'Min Cantidad',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.filter_list),
                        onPressed: () {
                          setState(() {
                            _applyFilters();
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _minQuantity = int.tryParse(value) ?? 1;
                      _applyFilters();
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.65, // Ajusta la relación de aspecto para mejor visualización
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ProductCard(
                  product: product,
                  onAddToCart: () => _addToCart(product),
                  onRate: (rating) => _rateProduct(index, rating),
                  onToggleFavorite: () => _toggleFavorite(product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
