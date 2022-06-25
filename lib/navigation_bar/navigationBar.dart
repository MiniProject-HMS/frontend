import 'package:flutter/material.dart';
import 'package:frontend/screens/complaint_page.dart';
import 'package:frontend/screens/profile_page.dart';

class NavBarr extends StatefulWidget {
  const NavBarr({Key? key}) : super(key: key);

  @override
  State<NavBarr> createState() => _NavBarrState();
}

class _NavBarrState extends State<NavBarr> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue);
  static const List<Widget> _widgetOptions = <Widget>[
    ScreenProfile(),
    ScreenComplaint(),
    Text(
      'Bill Information',
      style: optionStyle,
    ),
    Text(
      'QR scanner',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.black38,
        // fixedColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/profile_icon.png', height: 50,),
            label: '',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/complaints_icon.png', height: 50,),
            label: '',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/bill_info_icon.png', height: 50,),
            label: '',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/scanner_icon.png', height: 50,),
            label: '',
            backgroundColor: Colors.transparent,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
}
