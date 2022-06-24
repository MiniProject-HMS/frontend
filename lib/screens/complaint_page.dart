import 'package:flutter/material.dart';

class ScreenComplaint extends StatelessWidget {
  const ScreenComplaint({Key? key}) : super(key: key);

  // ignore: non_constant_identifier_names
  final complaints_list = 'as';

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
    );
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
        style: TextStyle(fontFamily: 'Arial', fontSize: 30),
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
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text('Create new compalints'),
          SizedBox(
            height: 20,
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter the complaint here',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Submit'))
        ],
      ),
    ));
  }
}
