import 'package:flutter/material.dart';

class ScreenComplaint extends StatelessWidget {
  const ScreenComplaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 0),
            child: Row(
              children: [
                const Text(
                  'Complaints Status',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Spacer(),
                IconButton(onPressed: (){}, icon: ImageIcon(AssetImage("assets/plus.png"),size: 24,))
              ],
            ),
          ),
          const Padding(
            padding: const EdgeInsets.fromLTRB(40.0,10.0,40.0,0),
            child: Divider(thickness: 5,),
          ),
        ],
      ),
      
    );
  }
}
