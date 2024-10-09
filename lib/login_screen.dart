import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

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
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            Text(
              _errorMessage,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.register);
              },
              child: Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    try {
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
}
