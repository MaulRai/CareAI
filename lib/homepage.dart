import 'package:careai/diagnose_page.dart';
import 'package:careai/image_analyzer_page.dart';
import 'package:careai/pseudo_speech_dart.dart';
import 'package:careai/user/profile_page.dart';
import 'package:careai/user/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Stack(
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 17, 255, 152),
                    Color.fromARGB(255, 17, 255, 231)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "CareAI",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 175,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final user = FirebaseAuth.instance.currentUser;
                          user == null
                              ? Get.to(() => const SignInPage())
                              : Get.to(() => const ProfilePage());
                        },
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Container(
                  alignment: AlignmentDirectional.topStart,
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Halo, User",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Apakah Anda memiliki keluhan?",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(ImageAnalyzerPage());
                        },
                        child: Text("Analisis Gambar"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(DiagnoseWithVoicePage());
                        },
                        child: Text("AI Diagnose Consultation"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/chatpage");
                        },
                        child: Text("Customer Service"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(PseudoSpeechPage());
                        },
                        child: Text("Pseudo Text to Speech"),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
