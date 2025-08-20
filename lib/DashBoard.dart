import 'package:flutter/material.dart';
import 'package:loginform/SharedPreferences.dart';
import 'package:loginform/login.dart';

class DaashBoard extends StatelessWidget {
  const DaashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("THIS IS DASHBOARD")),

          ElevatedButton(
            onPressed: () async {
              await _logout();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
              );
            },
            child: Text("Log out "),
          ),
        ],
      ),
    );
  }
}

_logout() async {
  await SharedpreferencesHelper().clearAll();
}
