import 'package:flutter/material.dart';
import 'user_profile.dart';
import 'users_screen.dart';

class NavBar extends StatefulWidget {
  final Map<String, dynamic>? userData;
  const NavBar({super.key, required this.userData});

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      UserProfileScreen(data: widget.userData),
      UserListScreen(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
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
            icon: Icon(Icons.book),
            label: 'Usuarios',
          ),
        ],
      ),
    );
  }
}