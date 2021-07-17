import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api extends StatefulWidget {
  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
  getUsers() async {
    var lst = [];
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsondata = jsonDecode(response.body);
    for (var i in jsondata) {
      UserModel user =
          UserModel(i['name'], i['username'], i['company']['name']);
      lst.add(user);
    }
    return lst;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: getUsers(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Text("nothing ni Api"),
              );
            } else
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(snapshot.data[i].name),
                      subtitle: Text(snapshot.data[i].company),
                    );
                  });
          },
        ),
      ),
    );
  }
}

class UserModel {
  var name;
  var username;
  var company;

  UserModel(this.name, this.username, this.company);
}
