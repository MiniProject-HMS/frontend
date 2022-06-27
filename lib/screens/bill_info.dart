import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScreenBill extends StatefulWidget {
  const ScreenBill({Key? key}) : super(key: key);

  @override
  State<ScreenBill> createState() => _ScreenBillState();
}

class _ScreenBillState extends State<ScreenBill> {
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
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bill information',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              Divider(),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'Month',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'k',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'Year',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'k',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'Admission No',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'k',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'Messcut',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'k',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'Establishment Charge',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'k',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'Mess Fee',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'k',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'Fine',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'k',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'Last Date',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'k',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                    child: Text(
                      'Total',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                    child: Text(
                      'k',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
