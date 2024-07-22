import 'package:careai/app_decoration.dart';
import 'package:careai/user/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget appButton(String text, BuildContext context, bool isLogin, {Function? loginHandle}) {
  return GestureDetector(
    onTap: () {
      (isLogin)
          ? loginHandle!()
          : Get.to(SignUpPage());
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 15),
      width: 325,
      height: 50,
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      )),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}

Widget appTextField({
  TextEditingController? controller,
  String text = "",
  Widget icon = const Icon(Icons.person),
  String hintText = "Type here",
  bool obscureText = false,
}) {
  return Container(
    padding: EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        Container(
          width: 325,
          height: 50,
          decoration: boxDecoration(),
          child: Row(
            children: [
              Container(margin: EdgeInsets.only(left: 12), child: icon),
              Container(
                width: 270,
                height: 45,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  onChanged: (value) {},
                  maxLines: 1,
                  autocorrect: false,
                  obscureText: obscureText,
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
