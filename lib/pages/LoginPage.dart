// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thewall1/components/login_button.dart';
import 'package:thewall1/components/text_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text edting controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  //sign in user
  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
    } on FirebaseAuthException catch (e) {
      displayMessage('Invalid information');
    }
  }

  //display error message
  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //logo

              Icon(
                Icons.workspaces_outline,
                size: 100,
              ),

              SizedBox(
                height: 15,
              ),

              Text(
                'Welcome back!',
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),

              SizedBox(
                height: 25,
              ),

              //Email text field

              MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  obscureText: false),

              SizedBox(
                height: 10,
              ),

              //Password text field

              MyTextField(
                  controller: passwordTextController,
                  hintText: 'Password',
                  obscureText: true),

              SizedBox(
                height: 25,
              ),

              //Button

              LoginButton(
                onTap: signIn,
                text: 'Login',
              ),

              SizedBox(
                height: 25,
              ),
              //Registration redirect

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?',
                      style: TextStyle(color: Colors.grey[600], fontSize: 15)),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Join now',
                      style: TextStyle(
                          color: Colors.blue[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
