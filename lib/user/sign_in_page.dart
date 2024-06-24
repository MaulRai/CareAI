import 'package:careai/app_decoration.dart';
import 'package:careai/gesture_widgets.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Log in")),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              thirdPartyLogin(),
              Text("Or use your email account to login"),
              appTextField(text: "Email", hintText: "Enter your email address"),
              appTextField(
                  text: "Password",
                  icon: Icon(Icons.lock),
                  hintText: "Enter password",
                  obscureText: true),
              Container(child: textUnderLine("Forgot password?")),
              SizedBox(height: 100),
              appButton("Login", context, true),
              appButton("Sign up", context, false),
            ],
          ),
        ));
  }
}

Widget thirdPartyLogin() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 80),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _loginButton("resources/google_icon.png"),
        _loginButton("resources/apple_icon.png"),
        _loginButton("resources/dc_icon.png"),
      ],
    ),
  );
}

Widget _loginButton(String imagePath) {
  return GestureDetector(
    child: Container(
      width: 40,
      height: 40,
      child: Image.asset(imagePath),
    ),
  );
}




