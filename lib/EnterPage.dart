import 'package:expensetracker/ExpensesAndIncome.dart';
import 'package:expensetracker/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnterPage extends StatefulWidget {
  _EnterPageState createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
  Transact transact=Transact(amount: 200,id: 1,isSpent: 1);
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff17395c),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  children: <Widget>[
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          transact.amount=val as int;
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                    FlatButton(onPressed: () {
                      setState(() {
                        transact.isSpent=1;
                      });
                    }, child: Text("Food")),
                    FlatButton( child: Text("Travel")),
                    FlatButton(
                      onPressed: () async {
                        var json=transact.toMap();
                        int i=await DatabaseHelper.instance.insert(
                          json
                        );
                        print(i);
                      },
                      child: Text("submit"),
                    ),
                    RaisedButton(
                      child: Text("Date"),
                      onPressed: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2015),
                            lastDate: DateTime(2101));
                      },
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff17395c),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
