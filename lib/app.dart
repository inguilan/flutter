import 'package:flutter/material.dart';
import 'screens/shopping_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Palmicafé',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        hintColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const ShoppingListScreen(),
    );
  }
}
