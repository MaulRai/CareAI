import 'package:careai/chat_page.dart';
import 'package:careai/firebase_options.dart';
import 'package:careai/homepage.dart';
import 'package:careai/user/auth.dart';
import 'package:careai/user/sign_in_page.dart';
import 'package:careai/user/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        '/homepage': (context) => const HomePage(),
        '/chatpage': (context) => const ChatPage(),
        '/signinpage': (context) => const SignInPage(),
        '/signuppage': (context) => const SignUpPage(),
        // '/Loginpage' : (context) => const LoginPage(),
        // '/examplepage': (context) => const ExPage(),
      },
    );
  }
}
