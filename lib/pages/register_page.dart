// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thewall1/components/login_button.dart';
import 'package:thewall1/components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text edting controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //signup

  void signUp() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    //make sure confirm password matches
    if (passwordTextController.text != confirmPasswordController.text) {
      //pop the loading
      Navigator.pop(context);

      //display error
      displayMessage("Passwords don't match");
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }

  //display error
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
                height: 25,
              ),

              Text(
                'Welcome, to ChatterBox!',
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
                height: 10,
              ),

              MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm password',
                  obscureText: true),

              SizedBox(
                height: 25,
              ),

              //Button

              LoginButton(
                onTap: signUp,
                text: 'Create Account',
              ),

              SizedBox(
                height: 25,
              ),
              //Registration redirect

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',
                      style: TextStyle(color: Colors.grey[600], fontSize: 15)),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Login',
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
