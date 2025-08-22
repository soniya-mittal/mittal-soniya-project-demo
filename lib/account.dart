import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loginform/Service.dart';
import 'package:loginform/login.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _namefocus = FocusNode();
  final _emailfocus = FocusNode();
  final _phonefocus = FocusNode();
  final _passwordfocus = FocusNode();
  bool isPass = true;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUnfocus,
            child: Column(
              children: [
                Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Welcome! Let's set up your account",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),

                SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  focusNode: _namefocus,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    suffixIcon: Icon(Icons.person),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_emailfocus);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value)) {
                      return 'Name can only contain letters, spaces, hyphens, and apostrophes';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  focusNode: _emailfocus,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    suffixIcon: Icon(Icons.email),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_phonefocus);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your email";
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
                  controller: phoneController,
                  focusNode: _phonefocus,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    suffixIcon: Icon(Icons.phone),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordfocus);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your phone number";
                    }
                    if (value.length > 10) {
                      return "phone number must be atleast 10 digits";
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter only digits.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  focusNode: _passwordfocus,
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
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).unfocus();
                    createAccount();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please Enter your password";
                    }
                    if (value.length < 6) {
                      return "password must be atleast 6 digits";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 90,
                  width: 600,

                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.deepOrangeAccent,
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final Map<String, dynamic> response = await ApiService()
                          .register(
                            nameController.text,
                             emailController.text, 
                             phoneController.text,
                              passwordController.text
                              );
                              
                              
                    },
                    child: Text(
                      "Create Account",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(height: 30),
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
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),

                SizedBox(height: 30),
                Container(
                  height: 65,
                  width: 550,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: Colors.grey),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign up With Google",
                        style: TextStyle(color: Colors.black, fontSize: 18),
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
                      "Don't have an account?",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')),
                          );
                        }

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Image.asset('assets/background.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createAccount() {}
}
