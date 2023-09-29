import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  final String id;
  final String name;
  final String price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://localhost:8001/produtos'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<Product> loadedProducts = [];

      for (final productData in responseData) {
        loadedProducts.add(
          Product(
            id: productData['id'],
            name: productData['name'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
          ),
        );
      }

      setState(() {
        products = loadedProducts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (ctx, index) {
        return ProductItem(
          product: products[index],
        );
      },
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(product.imageUrl),
      title: Text(product.name),
      subtitle: Text(product.price),
      // Aqui está o produto
    );
  }
}
