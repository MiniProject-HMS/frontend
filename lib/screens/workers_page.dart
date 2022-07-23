import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScreenWorker extends StatefulWidget {
  const ScreenWorker({Key? key}) : super(key: key);

  @override
  State<ScreenWorker> createState() => _ScreenWorkerState();
}

class _ScreenWorkerState extends State<ScreenWorker> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  List complaintsList = [];

  @override
  void initState() {
    super.initState();
    fetctComplaintsForWorkers();
  }


  @override
  Widget build(BuildContext context) {
    
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
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Workers Page',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      leading: Text('Entry ${entries[index]}'),
                      trailing: Icon(Icons.check),
                      onTap: (){
                        print(index);
                      },
                    ),
                  );
                },
                
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            )
          ],
        ),
      ),
    );
  }


  Future fetctComplaintsForWorkers() async {
  final response = await http
      .get(Uri.parse('http://127.0.0.1:8000/api/works/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var complaint = jsonDecode(response.body);
    // print(complaint["data"]);
    complaintsList = complaint["data"];
    setState(() {
      complaintsList = complaint["data"];
      // complaintsList = jsonDecode(complaintsList);
    });
    print(complaintsList[5]);
    return "Album.fromJson(jsonDecode(response.body)";
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
}

