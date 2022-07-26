import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/screens/complaint_page.dart';
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
  bool fetchedData = false;

  @override
  void initState() {
    super.initState();
    _fetchComplaintsForWorkers();
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
              child: TileList(),
            )
          ],
        ),
      ),
    );
  }

  Widget TileList() {
    if (fetchedData) {
      if (complaintsList.isNotEmpty) {
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          itemCount: complaintsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: (Colors.transparent),
              child: ListTile(
                iconColor: (Colors.white),
                textColor: (Colors.white),
                title: Text('${complaintsList[index]["complaint_desc"]}'),
                leading: Text('${complaintsList[index]["room_no"]}'),
                trailing: Icon(Icons.close),
                onTap: () {
                  _showMyDialog(index);
                },
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        );
      } else {
        return Text("Nothing here...");
      }
    } else {
      return Text("Loading...");
    }
  }

  Future<void> _showMyDialog(index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Is it Finished?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('If the current work is done,'),
                Text('Please press the Finished button'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Finished'),
              onPressed: () async{
                var stat = await _postStatusComplaints('${complaintsList[index]["complaint_id"]}', 'True');
                // print('-> ${complaintsList[index]["complaint_id"]}');
                _fetchComplaintsForWorkers();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future _postStatusComplaints(complaintId, status) async {
    final response = await http.post(
    Uri.parse('https://hmslbs.herokuapp.com/api/works/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'complaint_id': '$complaintId',
      'status': '$status',
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    
    return response.body;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return response.body;
  }

  }

  Future _fetchComplaintsForWorkers() async {
    final response =
        await http.get(Uri.parse('https://hmslbs.herokuapp.com/api/works/'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var complaint = jsonDecode(response.body);
      // print(complaint["data"]);
      complaintsList.clear();

      for (int i = 0; i < complaint['data'].length; i++) {
        if (complaint['data'][i]['status'] == false) {
          setState(() {
            complaintsList.add(complaint["data"][i]);
          });
        }
      }

      fetchedData = true;
      // complaintsList = jsonDecode(complaintsList);

      // print(complaintsList.length);
      return true;
    } else {
      return false;
    }
  }
}
