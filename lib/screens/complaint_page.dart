import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
                                builder: (context) => const CreateComplaint()),
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
                  thickness: 5,
                ),
              ),
              _widgetNoComplaints(),
            ],
          ),
        ));
  }

  _widgetNoComplaints() {
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
                const SizedBox(
                  height: 50,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Enter new complaints here',
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      // filled: true
                    ),
                    maxLines: 5,
                    minLines: 3,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 40),
                        primary: Colors.white38),
                    child: const Text('Submit'))
              ],
            ),
          ),
        ));
  }
}
