import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  String userToken;

  Home(this.userToken, {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _opcaoSelecionada = 0;
  @override
  Widget build(BuildContext context) {    return MaterialApp(
    home: DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(title: Text("")),
      body:IndexedStack(
        index: _opcaoSelecionada,
        children: <Widget>[
          UserPage(),
          SearchPage()
        ],

      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _opcaoSelecionada,
        onTap: (opccao){
          setState(() {
            _opcaoSelecionada = opccao;
          });
        },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Usuarios'),
      ],)
      ),
    ));
  }
}

class UserPage extends StatelessWidget{
  const UserPage({Key?key}) : super(key:key);
  
  get userToken => null;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
        child: Text('Perfil do usuario'),
      ),
    );
  }
}


class SearchPage extends StatelessWidget{
  const SearchPage({Key?key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
        child: Text("lista de usuarios"),
      ),
    );
  }
}

