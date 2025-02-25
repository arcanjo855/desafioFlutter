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
          child: 
          InputFormName(),
          
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: 
          InputFormEmail(),
          
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


class InputFormName extends StatelessWidget {
  const InputFormName({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            suffixIcon: Icon(Icons.clear),
            labelText: 'name',
            border: OutlineInputBorder(),
          )
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
          )
    );
  }
}