import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class ScreenProfile extends StatelessWidget {
  ScreenProfile({Key? key}) : super(key: key);

  var box = Hive.box('dataStore');
  late var name;

  @override
  Widget build(BuildContext context) {
    if ((box.get('stName') == null) || (box.get('hostel') == null)) {
      fetchName();
    }
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/backgrounds/bg.png'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/icons/profile_icon.png'),
                      radius: 50.0,
                    ),
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                        child: box.get('stName') == null
                            ? Text(
                                '$name',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                '${box.get("stName")}',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                        child: Text(
                          "${box.get('adm_id')}",
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
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
                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                child: SizedBox(
                  width: double.infinity,
                  // height: 100.0,
                  child: Card(
                    // margin:
                    //     EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    clipBehavior: Clip.antiAlias,
                    color: Colors.transparent,
                    elevation: 5.0,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 22.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,10,0,0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '${box.get("hostel")}',
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${box.get("room_no")}',
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Latest Bill: ',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'APR 2022',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Last Paid: ',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                child: Text(
                                  'FEB 2022',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future fetchName() async {
    var admNo = box.get('adm_id');
    final response = await http.get(
        Uri.parse('https://hmslbs.herokuapp.com/api/profile/?admission_no=$admNo'));

    if (response.statusCode == 200) {
      var stName = jsonDecode(response.body)["data"][0];
      setState() {
        name = stName["name"];
      }

      box.put('stName', stName["name"]);
      box.put('hostel', stName["hostel"]);
      box.put('room_no', stName["room_no"]);
      return "success";
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
