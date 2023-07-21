// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thewall1/auth/login_or_register.dart';
import 'package:thewall1/pages/LoginPage.dart';
import 'package:thewall1/pages/register_page.dart';

import 'home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //user is logged in
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return LoginOrRegister();
            }
            //user is NOT logged  in
          }),
    );
  }
}
