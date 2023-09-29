import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:superexpress/app/pages/home/home.page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required String title});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://localhost:8001/login'), // URL do servidor local
      body: {
        'username': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Login bem-sucedido, redirecione para a página inicial
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } else {
      // Login falhou, exiba uma mensagem de erro
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
        padding: const EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: const Color(0xFFFFFFFF),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                width: 128,
                height: 128,
                child: Image.asset("assets/logo.png"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                  focusColor: Color(0xFFEE3F3E),
                ),
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Digite seu e-mail.';
                  } else if (!email.contains('@')) {
                    return 'Digite um e-mail válido.';
                  }
                  return null;
                },
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                  focusColor: Color(0xFFEE3F3E),
                ),
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return 'Digite sua senha.';
                  } else if (password.length <= 6) {
                    return 'Digite uma senha mais forte.';
                  }
                  return null;
                },
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Container(
                height: 40,
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text(
                    "Esqueceu a senha",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEE3F3E),
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    // Lógica para lidar com a solicitação de redefinição de senha
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    stops: [0.3, 1],
                    colors: [Color(0xFFEE3F3E), Color(0xFFF5DE34)],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: SizedBox.expand(
                  child: TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 28,
                          width: 28,
                          child: Image.asset("assets/shop_cart.png"),
                        )
                      ],
                    ),
                    onPressed:
                        _login, // Chame a função de login ao pressionar o botão
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  color: Color(0xFF3C5A99),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: SizedBox.expand(
                  child: TextButton(
                    onPressed: () {
                      // Lógica para lidar com o login com o Facebook
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          "Login com Facebook",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 28,
                          width: 28,
                          child: Image.asset("assets/fb-icon.png"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                child: TextButton(
                  onPressed: () {
                    // Lógica para lidar com o botão de cadastro
                  },
                  child: const Text(
                    "Cadastre-se",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEE3F3E),
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
