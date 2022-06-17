import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'screens/login_page.dart';

Future<void> main() async {
  runApp(const HMS());
}

class HMS extends StatelessWidget {
  const HMS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HMS",
      theme: ThemeData(primaryColor: Colors.blue),
      home: const SafeArea(
        child: ScreenLogin(),
      ),
    );
  }
}
