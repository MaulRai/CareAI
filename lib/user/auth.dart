import 'package:careai/dashboard.dart';
import 'package:careai/user/sign_in_page.dart';
import 'package:careai/user/signup_empass_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const SignInPage())
        : Get.offAll(() => const Dashboard());
  }

  void createUserWithEmailAndPass(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      debugPrint("Done created User!");
      firebaseUser.value == null
        ? Get.to(() => const SignInPage())
        : Get.offAll(() => const Dashboard());
    } on FirebaseAuthException catch (e){
      final ex = SignUpWithEmailAndPassFailure.code(e.code);
      debugPrint("The firebase error is ${ex.message}");
      throw ex;
    } catch (_){
      final ex = SignUpWithEmailAndPassFailure();
      debugPrint("The error is ${ex.message}");
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPass(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){

    } catch (_){}
  }

  Future<void> logout() async => await _auth.signOut();
}
