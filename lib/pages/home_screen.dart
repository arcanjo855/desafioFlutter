import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  String userToken;

  Home(this.userToken, {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home page"),
        centerTitle: true,
      ),
      
      body: Center(
        child: Text(widget.userToken),
      )
    );
  }
}