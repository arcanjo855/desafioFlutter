import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:desafio_flutter/main.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController areaCodeController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

Future<void> register() async {
  if (_formKey.currentState!.validate()) {
    }
    final url = "http://10.2.3.59:3000/register";


    var body = json.encode({
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'area_code': areaCodeController.text,
      'number': numberController.text
    });

    final res = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );


    
    if (res.statusCode == 200) {
        Navigator.push(context, 
        MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro ao fazer cadastro'),
              content: Text('Nao foi possivel fazer o cadastro'),
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
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu nome';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite um e-mail válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite uma senha';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  maxLength: 2,
                  controller: areaCodeController,
                  decoration: InputDecoration(labelText: 'DDD'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.length != 2) {
                      return 'Digite um DDD válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  maxLength: 9,
                  controller: numberController,
                  decoration: InputDecoration(labelText: 'Telefone'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Digite um telefone válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: register,
                  child: Text('Registrar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('Ja tem uma conta? Faca login'),
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
    home: RegisterScreen(),
  ));
}



