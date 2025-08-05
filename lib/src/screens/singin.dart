import 'dart:convert';
import 'package:doubles/src/service/auth/signin_service.dart';
import 'package:doubles/src/service/baseUrl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/button.dart';
import '../widgets/main_text.dart';
import '../widgets/text_field_input.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;
  SignInService _loginService = SignInService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> _handleSignin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final loginResponse = await _loginService.signIn(
        _emailController.text,
        _passwordController.text,
      );

      print(loginResponse.data);

      if (loginResponse != null && loginResponse.data != null) {
        // ✅ Save token using SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', loginResponse.token);
        await prefs.setInt('userId', loginResponse.data.id);


        // ✅ Navigate based on first time user
        if (loginResponse.data.firstTimeUser) {
          Navigator.pushNamed(context, "/profile", arguments: loginResponse.data);
        } else {
          Navigator.pushNamed(context, "/home", arguments: loginResponse.data);
        }
      }

      setState(() => _isLoading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 10),
          child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/login");
              },
              child: MainText(
                text: "Cancel",
                color: Colors.black,
              )),
        ),
        title: MainText(text: "Sign in", color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: "ENTER YOUR EMAIL ADDRESS",
                color: Colors.black,
              ),
              Form(
                  key: _formKey,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldInput(
                          label: "Email",
                          hintText: "user@gmail.com",
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            } else if (!_isValidEmail(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldInput(
                          isPasswordField: true,
                          label: "Password",
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Button(
                          text: "Sign in",
                          onTap: _handleSignin,
                          width: MediaQuery.of(context).size.width,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: MainText(
                              text: "Forgot password?",
                              color: Colors.blue,
                              textAlign: TextAlign.start,
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        MainText(
                          text: "OTHER SIGN IN METHODS",
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Button(
                          text: "Continue with Google",
                          withIcon: true,
                          color: Colors.white,
                          iconImage: "assets/images/google.png",
                          width: MediaQuery.of(context).size.width,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Button(
                          text: "Continue with Facebook",
                          withIcon: true,
                          color: Colors.white,
                          iconImage: "assets/images/facebook.png",
                          width: MediaQuery.of(context).size.width,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Button(
                          text: "Continue with X",
                          withIcon: true,
                          color: Colors.white,
                          iconImage: "assets/images/twitter.png",
                          width: MediaQuery.of(context).size.width,
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
