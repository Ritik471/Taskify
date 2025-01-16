import 'package:flutter/material.dart';
import 'package:task_app/features/auth/pages/login.dart';
import 'package:task_app/model/database_helper.dart';

class Signup extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const Signup());
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    if (formKey.currentState!.validate()) {
      final dbHelper = DatabaseHelper.instance;

      // Check if user already exists
      final existingUser = await dbHelper.getUser(emailController.text.trim());
      if (existingUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            'Email already exists. Try logging in.',
            style: TextStyle(color: Colors.red, fontSize: 15),
          )),
        );
        return; // Exit the function if the user exists
      }

      final user = {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      };

      try {
        await dbHelper.insertUser(user);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Signup Successful!',
                  style: TextStyle(color: Colors.green, fontSize: 15))),
        );
        Navigator.of(context).pushReplacement(
          LoginPage.route(),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error signing up. Please try again.',
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name field cannot be Empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty ||
                    !value.contains('@')) {
                  return 'Email field is invalid';
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty ||
                    value.length <= 6) {
                  return 'Password field is Invalid';
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: signUpUser,
              child: Text(
                'SIGN UP',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(LoginPage.route());
              },
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
