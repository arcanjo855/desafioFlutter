import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyForm extends StatelessWidget {
  MyForm({super.key});
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passowordController = TextEditingController();
  final dddController = TextEditingController(); 
  final telefoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_box),
              suffixIcon: Icon(Icons.clear),
              labelText: 'Nome',
              border: OutlineInputBorder(),
            ),
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Digite seu nome';
              }
              return null;
            },
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail),
            suffixIcon: Icon(Icons.clear),
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          controller: emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Digite seu login';
            }
            return null;
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.key),
            suffixIcon: Icon(Icons.clear),
            labelText: 'senha',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
          controller: passowordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Digite sua senha!';
            }
            return null;
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            suffixIcon: Icon(Icons.clear),
            labelText: 'DDD',
            border: OutlineInputBorder(),
          ),
          controller: dddController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Digite seu DDD';
            }
            return null;
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            suffixIcon: Icon(Icons.clear),
            labelText: 'Telefone',
            border: OutlineInputBorder(),
          ),
          controller: telefoneController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Digite seu nome';
            }
            return null;
          },
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              // Faz o que tá aqui quando tá valido!d
            }
          },
          child: const Text('Enviar'),
        )
      ]),
    );
  }
}
