import 'package:flutter/material.dart';

class Users extends StatefulWidget {

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(title: Text("usuarios")),
      body: Center(
        child: Text('lista de usuarios'),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Usuarios'),
      ],)
      ),
    ));
  }
}
