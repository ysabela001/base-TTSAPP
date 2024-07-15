import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  UserProvider() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

//get para verificar se o user esta logado - retorna "true or false"
  bool get isAuthenticated => _user != null;

//get para obter dados do user
  User? get user => _user;

//fun deslogar user
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
