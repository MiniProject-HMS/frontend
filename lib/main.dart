import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/login_page.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('loginBox');
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
