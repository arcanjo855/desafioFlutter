import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final storage = FlutterSecureStorage();
  String? token;
  Map<String, dynamic>? data;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    token = await storage.read(key: 'token');
    if (token != null) {
      await _fetchData();
    } else {
      setState(() {
        isLoading = false;
        errorMessage = "Token não encontrado.";
      });
    }
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.18.6:3000/userInfo'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic>) {
          setState(() {
            data = responseData;
            isLoading = false;
          });
        } else {
          throw Exception("Formato de resposta inesperado.");
        }
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Erro ao buscar dados: ${response.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Erro na requisição: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            appBar: AppBar(title: Text('Carregando...')),
            body: Center(child: CircularProgressIndicator()),
          )
        : errorMessage != null
            ? Scaffold(
                appBar: AppBar(title: Text('Erro')),
                body: Center(child: Text(errorMessage!, style: TextStyle(color: Colors.red))),
              )
            : NavBar(userData: data);
  }
}