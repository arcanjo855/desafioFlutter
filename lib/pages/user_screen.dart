import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = FlutterSecureStorage();
  String? token;
  List<dynamic>? data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  // Carregar o token armazenado
  _loadToken() async {
    
    token = await storage.read(key: 'token');
    print(token);
    if (token != null) {
      
      _fetchData();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  

  // Buscar dados da API com o token JWT
  _fetchData() async {
    print(token);
    final response = await http.get(
      Uri.parse('http://192.168.18.6:3000/userInfo'),
      headers: {
        'Authorization': 'Bearer ${[token]}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      
      setState(() {
        data = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // Exibir mensagem de erro caso necessário
      print('Erro ao buscar dados: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dados do PostgreSQL')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : data == null
              ? Center(child: Text('Token não encontrado.'))
              : ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(data![index]['nome']), // exemplo de campo
                      subtitle: Text(data![index]['descricao']), // exemplo de campo
                    );
                  },
                ),
    );
  }
}