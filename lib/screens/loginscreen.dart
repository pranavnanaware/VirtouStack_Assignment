import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:pranavnanaware/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void login() async {
    final facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        storeToken(result.accessToken.token);
        navigateToHomepage(result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('User cancelled logging in');
        break;
      case FacebookLoginStatus.error:
        print('Error: ' + result.errorMessage);
        break;
    }
  }

  void storeToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);
  }

  void navigateToHomepage(token) {
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(
        builder: (context) => new HomePage(token: token),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Sign In",
              style: kHeadingStyle.copyWith(fontSize: 25.0, color: Color.fromRGBO(241, 241, 241, 100)),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Text(
            "Sign in with your facebook account",
            style: kTitleStyle.copyWith(fontSize: 17.0, color: Color.fromRGBO(241, 241, 241, 100)),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          FacebookSignInButton(
            onPressed: (){
              login();
            }
          )
        ],
      ),
    );
  }
}