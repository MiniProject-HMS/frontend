import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,20,0,0),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://static.vecteezy.com/system/resources/previews/004/773/704/non_2x/a-girl-s-face-with-a-beautiful-smile-a-female-avatar-for-a-website-and-social-network-vector.jpg",
                    ),
                    radius: 50.0,
                  ),
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                      child: Text(
                        "Aneeta T Rose",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                      child: Text(
                        '2019012',
                        style: TextStyle(
                          fontSize: 21.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0,0,20.0,20.0),
              child: SizedBox(
                width: double.infinity,
                // height: 100.0,
                child: Card(
                  // margin:
                  //     EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.grey,
                  elevation: 5.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 22.0),
                    child: Text('asd'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
