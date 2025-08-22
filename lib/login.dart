import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginform/DashBoard.dart';
import 'package:loginform/Service.dart';
import 'package:loginform/SharedPreferences.dart';
import 'package:loginform/account.dart';
import 'package:another_flushbar/flushbar.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailfocus = FocusNode();
  final _passwordfocus = FocusNode();
  bool _rememberMe = false;

  bool isPass = true;
  bool isload = false;

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isload = true;
      });

      String email = _emailController.text;
      String password = _passwordController.text;

      final Map<String, dynamic> response = await ApiService().login(
        email,
        password,
      );

      setState(() {
        isload = false;
      });

      if (response['status'] == true) {
        // save token
        SharedpreferencesHelper().saveData("token", response['data']['token']);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DaashBoard()),
        );
      } else {
        print("---Failed---$response");
        print("+++++++${response['message']}");
      }

      Flushbar(
        message: response['message'],
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        flushbarPosition: FlushbarPosition.TOP, 
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUnfocus, // auto validate
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome Again!',
                  style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Welcome back, you have been missed!',
                  style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),

                TextFormField(
                  enableInteractiveSelection: true,
                  controller: _emailController,
                  focusNode: _emailfocus,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.email_outlined),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 150, 129, 129),
                      ),
                    ),
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordfocus);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter email";
                    }
                    String pattern =
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
                    if (!RegExp(pattern).hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                TextFormField(
                  focusNode: _passwordfocus,
                  controller: _passwordController,
                  obscureText: isPass,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPass ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isPass = !isPass;
                        });
                      },
                    ),
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).unfocus();
                    _handleLogin();
                  },

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 30),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,

                      onChanged: (bool? newValue) {
                        setState(() {
                          _rememberMe = newValue ?? false;
                        });
                      },
                    ),
                    Text(
                      "Remember me",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),

                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                if (isload)
                  CircularProgressIndicator()
                else
                  SizedBox(
                    height: 90,
                    width: 550,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        _handleLogin();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Divider(
                        indent: 5,
                        color: Colors.grey,
                        endIndent: 5,
                        thickness: 3,
                      ),
                    ),
                    Text(
                      "Or Continue With",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),

                    SizedBox(
                      width: 50,
                      child: Divider(
                        indent: 5,
                        color: Colors.grey,
                        endIndent: 5,
                        thickness: 3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  width: 352,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login with Google",
                        style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                      ),
                      SizedBox(width: 10),
                      Image.asset('assets/Google 1.png', height: 24.0),
                    ],
                  ),
                ),

                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => AccountPage()),
                        );
                      },
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                Image.asset('assets/background.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
