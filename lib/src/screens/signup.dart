import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/button.dart';
import '../widgets/main_text.dart';
import '../widgets/text_field_input.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
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

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final response = await http.post(
        Uri.parse('https://doublesapi.vercel.app/api/v1/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _emailController.text,
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'password': _passwordController.text,
        }),
      );

      print(response.body);

      if (response.statusCode == 201) {
        print('Signup successful');
        setState(() {
          _errorMessage = null;
          _isLoading = false;
        });
        Navigator.pushNamed(context, '/signin');
      } else {
        try {
          final errorBody = jsonDecode(response.body);
          setState(() => _errorMessage = errorBody['message'] ?? 'Signup failed');
        } catch (e) {
          setState(() => _errorMessage = 'Signup failed: ${response.body}');
        }
        if (_errorMessage != null) {
          _showSnackbar(_errorMessage!);
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
              Navigator.pop(context);
            },
            child: MainText(text: "Cancel", color: Colors.black),
          ),
        ),
        title: MainText(text: "Sign up", color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(text: "REGISTER YOUR ACCOUNT", color: Colors.black),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
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
                      SizedBox(height: 20),
                      TextFieldInput(
                        label: "First Name",
                        controller: _firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'First Name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFieldInput(
                        label: "Last Name",
                        controller: _lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Last Name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFieldInput(
                        label: "Password",
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Button(text: "Sign up", onTap: _handleSignup),
                      SizedBox(height: 40),
                      MainText(text: "OTHER SIGN IN METHODS", color: Colors.black),
                      SizedBox(height: 10),
                      Button(text: "Continue with Google", withIcon: true, color: Colors.white, iconImage: "assets/images/google.png"),
                      SizedBox(height: 10),
                      Button(text: "Continue with Facebook", withIcon: true, color: Colors.white, iconImage: "assets/images/facebook.png"),
                      SizedBox(height: 10),
                      Button(text: "Continue with X", withIcon: true, color: Colors.white, iconImage: "assets/images/twitter.png"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
