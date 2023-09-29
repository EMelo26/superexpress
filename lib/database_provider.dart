import 'package:flutter/material.dart';
import 'database.dart'; // Importe a classe que lida com o banco de dados

class DatabaseProvider extends InheritedWidget {
  final Database database;

  DatabaseProvider({
    Key? key,
    required this.database,
    required Widget child,
  }) : super(key: key, child: child);

  static DatabaseProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DatabaseProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
