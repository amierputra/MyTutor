// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mytutor/views/mainscreen.dart';
import 'package:mytutor/constants.dart';
import 'package:mytutor/views/registerscreen.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double screenHeight, screenWidth, ctrwidth;
  bool remember = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: const Icon(Icons.email_rounded),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
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
                          controller: passwordController,
                          decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: const Icon(Icons.password_sharp),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
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
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(15)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ))),
                          onPressed: _loginUser,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: screenWidth,
                        height: 50,
                        child: ElevatedButton(
                          child: const Text("Register"),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(15)),
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ))),
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
    String _email = emailController.text;
    String _password = passwordController.text;
    print(_email);
    print(_password);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      http.post(
          Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/login_user.php"),
          body: {
            "email": _email,
            "password": _password,
            }).then((response) {
        print(response.body);
        var data = jsonDecode(response.body);
        print (data);
         if (response.statusCode == 200 && data['status'] == 'success') {
          User user = User.fromJson(data['data']);
          Fluttertoast.showToast(
              msg: "Welcome",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => MainScreen(user: user)));
        } else {
          Fluttertoast.showToast(
              msg: "Error",
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
