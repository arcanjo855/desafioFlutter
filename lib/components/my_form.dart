
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyForm extends StatelessWidget {
  MyForm({super.key});
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passowordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: 
          InputFormEmail(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: 
          InputFormPassowrd(),
          
        ),
       
        ElevatedButton(
          onPressed: fetchData,
          child: const Text('Enviar'),
        )
      ]),
    );
  }
}


class InputFormEmail extends StatelessWidget {
  const InputFormEmail({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            suffixIcon: Icon(Icons.clear),
            labelText: 'email',
            border: OutlineInputBorder(),
          ),
          validator: (value){
            if(value == null || value.isEmpty){
              return 'Digite seu email';
            }
            return null;
          },
    );
  }
}

class InputFormPassowrd extends StatelessWidget {
  const InputFormPassowrd({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.key),
            suffixIcon: Icon(Icons.clear),
            labelText: 'Senha',
            border: OutlineInputBorder(),
          ),
          validator: (value){
            if(value == null || value.isEmpty){
              return 'Digite sua senha';
            }else{
              return null;
            }
          }
    );
  }
}





fetchData() async{
                var url = Uri.parse('http://10.2.3.59:3000/usuarios');
                var response = await http.get(url);
                if(response.statusCode == 200){
                  print(response.body);
                }else{
                  print('nao foi');
                }
              }

Future<http.Response?> login(String email, String password) {
  return http.post(
    Uri.parse('http://10.2.3.59:3000/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email':'teste@mail.com', 'password':'123'}),
  );
}
  


