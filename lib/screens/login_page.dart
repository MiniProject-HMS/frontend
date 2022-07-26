import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/navigation_bar/navigationBar.dart';
import 'package:frontend/screens/workers_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/backgrounds/bg.png'),
        fit: BoxFit.cover,
      )),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(
              height: 3,
            ),
            Center(
                child: Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[300],
                fontSize: 50,
              ),
            )),
            const SizedBox(
              height: 20,
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
                    prefixIcon: Icon(Icons.account_box),
                    border: UnderlineInputBorder(),
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
                    prefixIcon: Icon(Icons.key),
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   // color: Colors.blue[50],
            //   width: double.infinity,
            //   child: Align(
            //     alignment: Alignment.centerRight,
            //     child: TextButton(
            //       onPressed: () {
            //         //forgot password screen
            //       },
            //       child: const Text(
            //         'Forgot Password',
            //       ),
            //     ),
            //   ),
            // ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.grey[350],),
                  
                  child: const Text('Login'),
                  onPressed: () async {
                    if (_formValidator()) {
                      //POST request goes here. if success, then store a boolean to hivebox loginbox and
                      //if box is empty then open login page else directly go to profile dashboard with the
                      //id stored in hivebox.
                      var a = await _postLogin(
                          nameController.text, passwordController.text);
                      // print(a);
                      if (a == 'success') {
                        _snackbar(a);
                        _storeDataToLocal();
                        print((nameController.text).contains('1999'));
                        if ((nameController.text).contains('1999')) {
                          _navigateToWorker();
                          var accessWorker = Hive.box("dataStore");
                          accessWorker.put('isWorker', true);
                        } else {
                          _navigateToProfile();
                        }
                      } else {
                        _snackbar('Unsuccessful');
                      }
                    }
                    print(nameController.text);
                    print(passwordController.text);
                  },
                )),
          ],
        ),
      ),
    );
  }

  _navigateToWorker() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ScreenWorker(),
      ),
    );
  }

  _snackbar(message) async {
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

  Future<String> _postLogin(id, passw) async {
    try {
      var response = await http.post(
        Uri.parse('https://hmslbs.herokuapp.com/api/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {'admission_no': id, 'password': passw},
        ),
      );
      var a = jsonDecode(response.body);
      var box = Hive.box('dataStore');
      box.put('adm_id', id);
      return (a['status']);
    } catch (e) {
      return e.toString();
    }
  }

  //replace qith Navigator.pushReplacement
  _navigateToProfile() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const NavBarr(),
      ),
    );
  }

  _storeDataToLocal() {
    var box = Hive.box('loginBox');
    box.put('isLoggedIn', true);
  }
}
