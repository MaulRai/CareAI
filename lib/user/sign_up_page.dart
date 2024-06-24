import 'package:careai/app_decoration.dart';
import 'package:careai/gesture_widgets.dart';
import 'package:careai/user/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final controller = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sign Up")),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                appTextField(
                    text: "Email",
                    hintText: "Enter your email address",
                    controller: controller.email),
                appTextField(
                    text: "Full Name",
                    hintText: "Enter your full name",
                    controller: controller.fullName),
                appTextField(
                    text: "Phone Number",
                    hintText: "Enter your phone number",
                    controller: controller.phoneNo),
                appTextField(
                    text: "Password",
                    icon: Icon(Icons.lock),
                    hintText: "Enter password",
                    obscureText: true,
                    controller: controller.password),
                appTextField(
                    text: "Re-enter password",
                    icon: Icon(Icons.lock),
                    hintText: "Enter password",
                    obscureText: true),
                SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      SignUpController.instance.registerUser(
                          controller.email.text.trim(),
                          controller.password.text.trim());
                    }
                  },
                  child: Text("Sign up"),
                )
              ],
            ),
          ),
        ));
  }
}
