import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String username, String password) async {
    // Lógica de autenticação aqui (exemplo simplificado)
    if (username == 'seu_usuario' && password == 'sua_senha') {
      _isAuthenticated = true;
      notifyListeners();
    } else {
      _isAuthenticated = false;
      notifyListeners();
    }
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
