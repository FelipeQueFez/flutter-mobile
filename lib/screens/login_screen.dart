import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreen,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Login',
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
                ElevatedButton(
                  onPressed: _login,
                  child: Text(
                    'Login',
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
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.register);
                  },
                  child: Text(
                    'Create an account',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primary[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    try {
      bool isValid = _validate();

      if (!isValid) {
        setState(() {});
        return;
      }

      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pushReplacementNamed(context, Routes.imageGallery);
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

    if (_passwordController.text.isEmpty) {
      _errorMessage = 'Inform the password';
      return false;
    }

    return true;
  }
}
