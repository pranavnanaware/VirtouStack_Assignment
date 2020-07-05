import 'package:http/http.dart' as http;
import 'dart:convert';

class Path {
  String id;
  String title;
  List<SubPath> subPaths;

  Path({this.id, this.title, this.subPaths});

 static getList(List<dynamic> json) {
  List<Path> list=List();
  list=json.map((i)=>Path.extractData(i)).toList();
  return  list;
}

  Path.extractData(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['sub_paths'] != null) {
      subPaths = new List<SubPath>();
      json['sub_paths'].forEach((v) {
        subPaths.add(new SubPath.extractData(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.subPaths != null) {
      data['sub_paths'] = this.subPaths.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubPath {
  String id;
  String title;
  String image;

  SubPath({this.id, this.title, this.image});

  SubPath.extractData(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}

class PathApiProvider {

  String url = "https://5d55541936ad770014ccdf2d.mockapi.io/api/v1/paths";

  Future<List<Path>> getData() async {
    final response = await http.get(url);
    final int statusCode=response.statusCode;
    if(statusCode < 200) {
      throw new Exception("$statusCode");
    }
    return Path.getList(json.decode(response.body));
  }
}