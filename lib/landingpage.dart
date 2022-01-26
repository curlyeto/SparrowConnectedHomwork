import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sparrowconnected_homework/core/viewmodel/authviewmodel.dart';
import 'package:sparrowconnected_homework/view/loginpage.dart';
import 'package:sparrowconnected_homework/view/newspage.dart';
import 'package:lottie/lottie.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<AuthViewModel>(context, listen: true);
    if (_userModel.state == ViewState.Idle) {
      if (_userModel.user == null) {
        return const LoginPage();
      } else {
        return const NewsPage();
      }
    } else {
      return Scaffold(
        body: Center(
          child: Lottie.asset('assets/json/loading.json'),
        ),
      );
    }
  }
}
