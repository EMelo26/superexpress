import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superexpress/database.dart';
import 'database_provider.dart'; // Importe a classe DatabaseProvider

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    // Agora você pode usar 'database' para acessar o banco de dados e executar consultas

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Produto',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Resto do seu código para a página de detalhes do produto
            ],
          ),
        ),
      ),
    );
  }
}
