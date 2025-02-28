import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:desafio_flutter/pages/register_screen.dart';// Importa a tela de registro
import 'package:desafio_flutter/pages/users_list_screen.dart';
import 'package:desafio_flutter/pages/user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final storage = FlutterSecureStorage();
  String? token;

Future<void> login() async {
    final url = "http://192.168.18.6:3000/login";


    var body = json.encode({
      'email': emailController.text,
      'password': passwordController.text,
    });

    final res = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    await storage.write(key: 'token', value: res.body);
    print('Token armazenado com sucesso!');
    
    if (res.statusCode == 200) {
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro ao fazer login'),
              content: Text('Email ou senha incorretas'),
              actions: [
                TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('./src/images/moon.png',
                width: 200,
                height: 200,),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Padding externo
                  child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite um e-mail válido';
                    }
                    return null;
                  },
                ),
                ),
                
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Padding externo
                  child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite a sua senha';
                    }
                    return null;
                  },
                ),
                ),
                
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: login,
                  child: Text('Login'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text('Não tem uma conta? Registre-se aqui'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}