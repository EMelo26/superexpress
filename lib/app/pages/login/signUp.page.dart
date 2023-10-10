import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.page.dart'; // Importe a classe LoginPage ou substitua pela classe real

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _telefoneController = TextEditingController();

  Future<void> _register(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final telefone = _telefoneController.text;

    final response = await http.post(
      Uri.parse(
          'http://seu_servidor/api/cadastrar'), // Substitua pela URL correta da sua API
      body: {
        'email': email,
        'password': password,
        'telefone': telefone,
      },
    );

    if (response.statusCode == 201) {
      // Cadastro bem-sucedido, redirecione o usuário
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(
              title:
                  "Pagina Inicial"), // Substitua pela classe real da página de login
        ),
      );
    } else {
      // Cadastro falhou, exiba uma mensagem de erro
      final responseData = jsonDecode(response.body);
      final errorMessage = responseData['error'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // Restante do seu código de construção da interface de cadastro aqui
          ),
    );
  }
}
