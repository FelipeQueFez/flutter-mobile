import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundScreen,
        iconTheme: IconThemeData(
          color: AppColors.primary,
        ),
      ),
      backgroundColor: AppColors.backgroundScreen,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Register',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: AppColors.background,
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: AppColors.background,
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    filled: true,
                    fillColor: AppColors.background,
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: _register,
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 80,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register() async {
    try {
      bool isValid = _validate();
      if (!isValid) {
        setState(() {});
        return;
      }

      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pushReplacementNamed(context, Routes.login);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  bool _validate() {
    if (_emailController.text.isEmpty) {
      _errorMessage = 'Inform the email';
      return false;
    }

    if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _errorMessage = 'Informe the password';
      return false;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _errorMessage = 'Passwords need to be the same';
      return false;
    }

    return true;
  }
}
