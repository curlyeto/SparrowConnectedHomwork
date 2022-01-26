import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sparrowconnected_homework/core/viewmodel/authviewmodel.dart';
import 'package:sparrowconnected_homework/view/costant/customtext.dart';
import 'package:sparrowconnected_homework/view/custom/toastmessage.dart';
import 'package:sparrowconnected_homework/view/newspage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ElevatedButton.icon(
              onPressed: () async {
                User? user = await context.read<AuthViewModel>().singInAnonymously();
                if (user != null) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NewsPage()));
                  MyToastMessage.myToastMessage(message: CustomText.loginSucText, color: Colors.green);
                } else {
                  MyToastMessage.myToastMessage(message: CustomText.incorrectLogText, color: Colors.red);
                }
              },
              icon: const Icon(Icons.person),
              label: Text(CustomText.loginWithGuestText),
            )
          ],
        ),
      ),
    );
  }
}
