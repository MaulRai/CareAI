import 'package:careai/homepage.dart';
import 'package:careai/user/auth.dart';
import 'package:careai/user/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  void registerUser(String email, String password){
    Get.offAll(() => const HomePage());
    AuthenticationRepository.instance.createUserWithEmailAndPass(email, password);
  }
}