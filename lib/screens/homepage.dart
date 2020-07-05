import 'dart:convert';
import 'package:pranavnanaware/Components/alert.dart';
import 'package:pranavnanaware/constants.dart';
import 'package:pranavnanaware/services/fetchdata.dart';
import 'package:flutter/services.dart';

import '../services/Apibrain.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'carousel.dart';

class HomePage extends StatefulWidget {
  final String token;
  const HomePage({Key key, this.token}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  ListDataStream list;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    list = ListDataStream()..getPath();
    if (widget.token != null) sharetoken(widget.token);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    list.dispose();
    super.dispose();
  }

  void sharetoken(String token) async {
    final response = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
    if (response.statusCode == 200) {
      alert(context, json.decode(response.body)['name']);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kbackgroundColor,
        title: Text(
          "Dog's Path",
          style: kTitleStyle.copyWith(color: Colors.white, fontWeight: FontWeight.normal)
        
        ),
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder<List<Path>>(
              stream: list.pathStream,
              builder: (context, AsyncSnapshot<List<Path>> snapshot) {
                if (snapshot.hasData) {
                  return Carousel(
                    pathList: snapshot.data,
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
