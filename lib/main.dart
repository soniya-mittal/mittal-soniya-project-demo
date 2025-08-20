import 'package:flutter/material.dart';
import 'package:loginform/DashBoard.dart';
import 'package:loginform/SharedPreferences.dart';
import 'package:loginform/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? initialRoute = await checktoken();
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',

      initialRoute: initialRoute,
      routes: {
        '/dashboard': (context) => DaashBoard(),
        '/login': (context) => LoginPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}


Future<String> checktoken() async {
  String? token;
  token = await SharedpreferencesHelper().getData('token');

  print("TOKEN from shared preferences---${token}");
  if (token != null) {
    return '/dashboard';
  } else {
    return '/login';
  }
}
