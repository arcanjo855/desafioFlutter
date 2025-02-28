import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<dynamic> users = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

Future<void> fetchUsers() async {
  final url = Uri.parse('http://192.168.18.6:3000/usuarios');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Verifica se a chave "users" existe e contém uma lista
      if (responseData.containsKey("users") && responseData["users"] is List) {
        List<dynamic> userList = responseData["users"];
        setState(() {
          users = userList; // Agora pega a lista corretamente
          isLoading = false;
          hasError = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  } catch (error) {
      setState(() {
        hasError = true;
        isLoading = false;
    });
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Lista de Usuários")),
    body: isLoading
        ? Center(child: CircularProgressIndicator())
        : hasError
            ? Center(child: Text("Erro ao carregar usuários!"))
            : users.isEmpty
                ? Center(child: Text("Nenhum usuário encontrado")) // Evita tela vazia
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];

                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              user['name'].isNotEmpty ? user['name'][0].toUpperCase() : "?",
                            ),
                          ),
                          title: Text(user['name'] ?? "Sem nome",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(user['email'] ?? "Sem e-mail"),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
                  ),
  );
}}