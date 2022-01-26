import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sparrowconnected_homework/core/viewmodel/authviewmodel.dart';
import 'package:sparrowconnected_homework/core/viewmodel/newsviewmodel.dart';
import 'package:sparrowconnected_homework/landingpage.dart';
import 'package:sparrowconnected_homework/locator.dart';
import 'package:sparrowconnected_homework/view/costant/customcolor.dart';
import 'package:sparrowconnected_homework/view/costant/customtext.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
      appId: '1:901289923148:android:466e92625a61506ee91ae9',
      apiKey: 'AIzaSyDNhaB0g3YxKpYCGow7hPAsOvWSH0NWgfg',
      projectId: 'sparrowhomework',
      messagingSenderId: '901289923148',
  ));
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider<NewsViewModel>(
          create: (context) => NewsViewModel(),
        ),
      ],
      child: MaterialApp(
        title: CustomText.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: CostomColor.appColor,
        ),
        home: const LandingPage(),
      ),
    );
  }
}
