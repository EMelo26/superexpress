import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<void> _login(BuildContext context) async {
    // Substitua com a URL correta da rota de login
    const String loginUrl = 'http://192.168.0.17:8001/login';

    // Substitua com o nome de usuário e senha desejados
    const String username = 'seu_usuario';
    const String password = 'sua_senha';

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Se o login for bem-sucedido, você pode executar ações adicionais aqui
        print('Login bem-sucedido');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login bem-sucedido'),
          ),
        );
      } else if (response.statusCode == 401) {
        // Trate o caso em que as credenciais são inválidas
        print('Credenciais inválidas');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Credenciais inválidas'),
          ),
        );
      } else {
        // Trate outros erros aqui
        print('Erro no servidor');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro no servidor'),
          ),
        );
      }
    } catch (error) {
      // Lida com erros de conexão ou outros erros
      print('Erro durante a solicitação: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro durante a solicitação'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _login(context),
          child: const Text('Login'),
        ),
      ),
    );
  }
}
