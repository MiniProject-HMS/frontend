import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class ScreenComplaint extends StatelessWidget {
  const ScreenComplaint({Key? key}) : super(key: key);

  // ignore: non_constant_identifier_names
  final complaints_list = 'as';

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
              _widgetNoComplaints(),
            ],
          ),
        ));
  }

  Widget _widgetNoComplaints() {
    if (complaints_list == '') {
      return (const Padding(
        padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0),
        child: Divider(
          thickness: 5,
        ),
      ));
    } else {
      return (const Text(
        'There are no complaints',
        style:
            TextStyle(fontFamily: 'Arial', fontSize: 30, color: Colors.white),
      ));
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
                    var status =
                        await _postComplaints(2019068, 404, _controller.text);
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

  Future<String> _postComplaints(admNo, roomNo, compDesc) async {
    Map<String, dynamic> complaintData = {'admission_no':admNo,'room_no':roomNo,'complaint_desc':compDesc};
    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/complaints/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          complaintData
        ),
      );
      print(response.body);
      var status = jsonDecode(response.body);
      return (status["status"]);
    } catch (e) {
      return 'Unsuccessfull';
    }
  }
  _popComplaintReg(){
    return (Navigator.pop(context));
  }
}
