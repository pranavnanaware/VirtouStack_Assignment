import 'dart:async';
import 'package:pranavnanaware/constants.dart';
import 'package:pranavnanaware/screens/homepage.dart';
import 'package:pranavnanaware/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pranav Nanaware',
      theme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      (){
        isLoggedIn();
      }
    );
  }

  Future isLoggedIn() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    String token = (preference.get('token') ?? null);
    if (token != null) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new HomePage()));
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/image.gif',
              height: size.height * 0.15,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            "Dog's Path",
            style: kHeadingStyle,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            "by",
            style: kSmallTextStyle,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            "VirtouStack Softwares Pvt. Ltd.",
            style: kTitleStyle,
          ),
        ],
      ),
    );
  }
}
