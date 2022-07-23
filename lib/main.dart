import 'package:flutter/material.dart';
import 'package:frontend/navigation_bar/navigationBar.dart';
import 'package:frontend/screens/workers_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/login_page.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('loginBox');
  await Hive.openBox('dataStore');
  runApp(const HMS());
}

class HMS extends StatelessWidget {
  const HMS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(_storeDataToLocal());
    if(_storeDataToLocal()==true){
      return MaterialApp(
      title: "HMS",
      theme: ThemeData(primaryColor: Colors.blue),
      home: const SafeArea(
        child: ScreenWorker(),
      ),
    );
    }
    return MaterialApp(
      title: "HMS",
      theme: ThemeData(primaryColor: Colors.blue),
      home: const SafeArea(
        child: ScreenLogin(),
      ),
    );
  }

  _storeDataToLocal() {
    var box = Hive.box('loginBox');
    //  box.put('isLoggedIn', false);
    //  box.put('isLoggedIn', true);
    return (box.get('isLoggedIn'));
  }
}
