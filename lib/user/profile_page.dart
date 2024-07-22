import 'package:careai/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profilePicture(),
            _logOutButton(),
          ],
        ),
      ),
    );
  }

  Widget _profilePicture() {
    return Stack(
      children: [
        Column(
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(40), // Image radius
                child: Image.asset("resources/karr.jpg"),
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
        Container(
          width: 85,
          height: 85,
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
            backgroundColor: Colors.blue[100],
            radius: 15,
            child: Icon(
              Icons.edit_square,
              color: Colors.blue,
            ),
          ),
        )
      ],
    );
  }
}

Widget _logOutButton() {
  return ElevatedButton(
    onPressed: () {
      FirebaseAuth.instance.signOut();
      Get.offAll(() => const HomePage());
    },
    child: Text("Log Out"),
  );
}
