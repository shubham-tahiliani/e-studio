import 'package:e_studio/ProductsPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Data.dart';
import 'SignUpPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isError = false;
  var errorText = 'Incorrect login details';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'e-Shop',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0C54BE),
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: inputDecoration('Email'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: inputDecoration("Password"),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                if (isError)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorText,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                Spacer(),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.7, // set your desired width
                  height: 50, // set your desired height
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(headColor),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => ProductsPage()),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print(e.code);
                            errorText = 'No user present with this email.';
                          } else if (e.code == 'wrong-password') {
                            print(e.code);
                            errorText = 'Wrong password, try another';
                          } else {
                            print('error $e');
                            print(e.code);
                            errorText = 'Invalid details';
                          }
                          setState(() {
                            isError = true;
                          });
                        }
                      }

                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    'New here? Signup',
                    style: TextStyle(
                      color: Color(0xFF0C54BE),
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
}
