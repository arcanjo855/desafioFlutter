import 'package:flutter/material.dart';

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
                      style: TextStyle(fontSize: 14),
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