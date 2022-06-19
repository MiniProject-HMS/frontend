import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _userIdformKey = GlobalKey<FormState>();
  final _userpassformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Form(
            key: _userIdformKey,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if (value.length < 7) {
                    return 'UserId is short';
                  }
                  return null;
                },
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
          ),
          Form(
            key: _userpassformKey,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
          ),
          SizedBox(
            // color: Colors.blue[50],
            width: double.infinity,
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Forgot Password',
                ),
              ),
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  if (_formValidator()) {
                    
                    //POST request goes here. if success, then store a boolean to hivebox loginbox and
                    //if box is empty then open login page else directly go to profile dashboard with the
                    //id stored in hivebox.
                    var a = _postLogin(nameController.text, passwordController.text);
                    print(a);
                    _snackbar(a);
                  }
                  print(nameController.text);
                  print(passwordController.text);
                },
              )),
        ],
      ),
    );
  }

  _snackbar(message) async{
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$message'),
      ),
    );
  }

  _formValidator() {
    if (_userIdformKey.currentState!.validate() &&
        _userpassformKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  _postLogin(id, passw) async {
    try {
      var response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            'data': {'adm_no': id, 'pass': passw}
          },
        ),
      );
      var a = jsonDecode(response.body);
      return(a['data']['adm_no']);
    } catch (e) {
      return e;
    }
    // print(response.body);
    // try {
    //   var response = await http.post(
    //   Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    //   body: {
    //
    //   }
    // );
    // print(response.body);
    // } catch(e) {
    //   print('error');
    //   print(e);
    // }
  }
}
