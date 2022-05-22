import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mytutor/views/mainscreen.dart';
import 'package:mytutor/views/registerscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double screenHeight, screenWidth, ctrwidth;
  bool remember = false;
  TextEditingController emailCtrller = TextEditingController();
  TextEditingController passwordCtrller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 800) {
      ctrwidth = screenWidth / 1.5;
    }
    if (screenWidth < 800) {
      ctrwidth = screenWidth;
    }
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: ctrwidth,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: screenHeight / 2.5,
                          width: screenWidth,
                          child: Image.asset('assets/images/mytutor.png')),
                      const Text(
                        "Login",
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: TextFormField(
                          controller: emailCtrller,
                          decoration: InputDecoration(
                              hintText: "Email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter valid email';
                            }
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value);

                            if (!emailValid) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: TextFormField(
                          controller: passwordCtrller,
                          decoration: InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(value: remember, onChanged: _onRememberMe),
                          const Text("Remember Me")
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: screenWidth,
                        height: 50,
                        child: ElevatedButton(
                          child: const Text("Login"),
                          onPressed: _loginUser,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: screenWidth,
                        height: 50,
                        child:  ElevatedButton(
                          child: const Text("Register"),
                          onPressed: () {
                            _navigateToNextScreen(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void _onRememberMe(bool? value) {
    setState(() {
      remember = value!;
    });
  }

  void _loginUser() {
    String _email = emailCtrller.text;
    String _password = passwordCtrller.text;
    print(_email);
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.post(
          Uri.parse(CONSTANTS.server + "/myshop/mobile/php/login_user.php"),
          body: {"email": _email, "password": _password}).then((response) {
        print(response.body);
        var data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          User user = User.fromJson(data['data']);
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => MainScreen(user: user)));
        } else {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        }
      });
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }
}
