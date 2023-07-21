import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const LoginButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 24, 23, 23),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
              child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ))),
    );
  }
}
