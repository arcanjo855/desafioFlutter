import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Página Home
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

  // Controlador da navegação
  int _currentIndex = 0; // Índice da tela ativa

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
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _currentIndex == 0
              ? UserProfileScreen(data: data) // Passando os dados do usuário
              : UserListScreen(), // Exibindo tela de configurações
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}

// Tela de perfil
class UserProfileScreen extends StatelessWidget {
  final Map<String, dynamic>? data;
  const UserProfileScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Center(child: Text("Dados não encontrados."));
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blueAccent,
                  child: Text(
                    (data!['name'] != null && data!['name'].isNotEmpty)
                        ? data!['name'][0].toUpperCase()
                        : "?",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  data!['name'] ?? "Sem nome",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  data!['email'] ?? "Sem e-mail",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                Divider(height: 30, thickness: 1),
                Row(
                  children: [
                    Icon(Icons.perm_identity, color: Colors.blueAccent),
                    SizedBox(width: 10),
                    Text(
                      "ID: ${data!['id'] ?? 'Desconhecido'}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.blueAccent),
                    SizedBox(width: 10),
                    Text(
                      "Criado em: ${data!['created_at']}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Tela com lista de usuarios
class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  UserListScreenState createState() => UserListScreenState();
}

class UserListScreenState extends State<UserListScreen> {
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