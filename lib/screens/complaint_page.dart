import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

// Pending works
// Call data from hive to get and post methods which is to be added through profile, which is not done yet
// Implement ValueNotifier to get method

class ScreenComplaint extends StatefulWidget {
  ScreenComplaint({Key? key}) : super(key: key);

  @override
  State<ScreenComplaint> createState() => _ScreenComplaintState();
}

class _ScreenComplaintState extends State<ScreenComplaint> {
  // ignore: non_constant_identifier_names
  // late String complaints_list = _getComplaints();

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
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 0),
                child: Row(
                  children: [
                    const Text(
                      'Complaints Status',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateComplaint()),
                          );
                        },
                        icon: const ImageIcon(
                          AssetImage("assets/icons/plus.png"),
                          size: 24,
                        ))
                  ],
                ),
              ),
              const Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Expanded(child: ListOfComplaints()),
            ],
          ),
        ));
  }
}

// Global declaration for preventing loading everytime
// ignore: non_constant_identifier_names
List complaints_list = [];
List complaint_status = [];
bool fetched = false;

class ListOfComplaints extends StatefulWidget {
  const ListOfComplaints({Key? key}) : super(key: key);

  @override
  State<ListOfComplaints> createState() => _ListOfComplaintsState();
}

class _ListOfComplaintsState extends State<ListOfComplaints> {
  @override
  void initState() {
    super.initState();
    if (!fetched) {
      fetchComplaints();
    }
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('dataStore');
    if (fetched == true) {
      if (complaints_list.isNotEmpty) {
        return (ListView.separated(
          padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0),
          itemCount: complaints_list.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: ListTile(
                textColor: Colors.white,
                title: Text('${complaints_list[index]}'),
                trailing: _statusViewer(index),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
      } else {
        return (const Text(
          'There are no complaints',
          style:
              TextStyle(fontFamily: 'Arial', fontSize: 30, color: Colors.white),
        ));
      }
    } else {
      return (const Text(
        'Loading...',
        style:
            TextStyle(fontFamily: 'Arial', fontSize: 30, color: Colors.white),
      ));
    }
  }

  _statusViewer(index) {
    if(complaint_status[index]){
      return const Icon(Icons.check,color: Colors.white,);
    }
    return const Icon(Icons.close, color: Colors.white,);
  }

  Future fetchComplaints() async {
    const url = 'http://127.0.0.1:8000/api/complaints/?room_no=404&hostel=MH1';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var complaintsList = jsonDecode(response.body);
      complaints_list.clear();
      complaint_status.clear();
      setState(() {
        fetched = true;
        for (var i = 0; i < complaintsList['data'].length; i++) {
          complaints_list.add(complaintsList['data'][i]['complaint_desc']);
          complaint_status.add(complaintsList['data'][i]['status']);
        }
      });
    } else {
      setState(() {
        fetched = false;
      });
    }
  }
}

class CreateComplaint extends StatefulWidget {
  const CreateComplaint({Key? key}) : super(key: key);

  @override
  State<CreateComplaint> createState() => _CreateComplaintState();
}

class _CreateComplaintState extends State<CreateComplaint> {
  final TextEditingController _controller = TextEditingController();
  final _complaintskey = GlobalKey<FormState>();

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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 90, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Create new complaints',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: Form(
                  key: _complaintskey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the complaint';
                      }
                      return null;
                    },
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.white),
                      // ),
                      hintText: 'Enter new complaints here',
                      // fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      // filled: true
                    ),
                    // maxLines: 5,
                    // minLines: 3,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  print(_controller.text);
                  if (_complaintskey.currentState!.validate()) {
                    var status = await _postComplaints(
                        2019068, 'MH1', 404, _controller.text);
                    if (status.toString() == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(status),
                        ),
                      );
                      _popComplaintReg();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(status),
                        ),
                      );
                    }
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.

                  }
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 40), primary: Colors.white38),
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _postComplaints(admNo, hostel, roomNo, compDesc) async {
    Map<String, dynamic> complaintData = {
      'admission_no': admNo,
      'hostel': hostel,
      'room_no': roomNo,
      'complaint_desc': compDesc
    };
    //change try to if by giving status code 200 condition
    //also change backend if request failed
    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/complaints/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(complaintData),
      );
      var status = jsonDecode(response.body);
      setState(() {
        fetched = false;
      });
      return (status["status"]);
    } catch (e) {
      return 'Unsuccessfull';
    }
  }

  _popComplaintReg() {
    return (Navigator.pop(context));
  }
}
