import 'package:firebase_authentication/auth/auth.dart';
import 'package:firebase_authentication/root/root_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Login ",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RootPage(
        auth: Auth(),
      ),
    );
  }
}
