import 'package:careai/app_decoration.dart';
import 'package:careai/gesture_widgets.dart';
import 'package:careai/homepage.dart';
import 'package:careai/user/sign_up_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String err = "";
  final controller = Get.put(SignUpController());
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
              appTextField(
                text: "Email",
                hintText: "Enter your email address",
                controller: controller.email,
              ),
              appTextField(
                  text: "Password",
                  icon: Icon(Icons.lock),
                  hintText: "Enter password",
                  obscureText: true,
                  controller: controller.password),
              warningText(err),
              Container(child: textUnderLine("Forgot password?")),
              SizedBox(height: 100),
              appButton("Login", context, true, loginHandle: _loginhandle),
              appButton("Sign up", context, false),
            ],
          ),
        ));
  }

  void _loginhandle() async {
    String errorMessage = "";
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: controller.email.text.trim(),
          password: controller.password.text.trim());
      Get.offAll(() => const HomePage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage = ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        errorMessage = ('Wrong password provided for that user.');
      } else if (e.code == 'invalid-credential'){
        errorMessage = ('Either your account isn\'t registered or worng password');

      }
      print("INI PESANNYA FIREBASE ++++++ ${e.code}");
    } catch (e) {
      print("INI PESANNYA ++++++ $e");
    }
    setState(() {
      err = errorMessage;
    });
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
