import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:expensetracker/ExpensesAndIncome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:koukicons/filmReel.dart';
import 'package:koukicons/send2.dart';
import 'EnterPage.dart';
import 'analytic.dart';

class HomePage extends StatefulWidget {
  @override
  int idx = 0;

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<charts.Series<ExpensesData, String>> seriesData;

  generateData() {
    var expData = [
      new ExpensesData("Expenses", 30000, Color(0xffc24229)),
      new ExpensesData("Savings", 50000, Color(0xffefb758))
    ];
    seriesData.add(charts.Series(
      data: expData,
      domainFn: (ExpensesData exp, _) => exp.st,
      measureFn: (ExpensesData exp, _) => exp.savings,
      colorFn: (ExpensesData exp, _) =>
          charts.ColorUtil.fromDartColor(exp.colour),
    ));
  }
  void initState() {
    super.initState();
    seriesData = List<charts.Series<ExpensesData, String>>();
    generateData();
  }

  Widget build(BuildContext context) {
    List pages = [
      DashBoard(
        seriesData: seriesData,
      ),EnterPage(),
      AnalyticPage(),
    ];
    List appBarTitle=["Hello Buddy!","Add Value","Analytics"];
    return SafeArea(
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xff17395c),
          title: new Text(
            appBarTitle[widget.idx],
            style: GoogleFonts.balooTammudu(
                fontSize: 20, color: Colors.white, letterSpacing: 1.5),
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          backgroundColor: Colors.white,
          color: Color(0xff17395c),
          items: <Widget>[
            Icon(Icons.dashboard, size: 20),
            Icon(Icons.add, size: 20),
            Icon(Icons.show_chart, size: 20),
          ],
          onTap: (index) {
            setState(() {
              widget.idx = index;
            });
          },
        ),
        backgroundColor: Color(0xff17395c),
        body: pages[widget.idx],
      ),
    );
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({
    Key key,
    @required this.seriesData,
  }) : super(key: key);

  final List<charts.Series<ExpensesData, String>> seriesData;

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Row(
            children: <Widget>[
              Container(
                height: 250,
                width: 250,
                child: charts.PieChart(
                  widget.seriesData,
                  animate: true,
                  animationDuration: Duration(seconds: 1),
                  defaultRenderer: new charts.ArcRendererConfig(
                      arcWidth: 60,
                      startAngle: 1.5 * pi,
                      arcLength: 2 * pi,
                      arcRendererDecorators: [
                        new charts.ArcLabelDecorator(
                            labelPosition: charts.ArcLabelPosition.inside)
                      ]),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Balance",
                      style: GoogleFonts.quicksand(
                          fontSize: 15, color: Colors.white)),
                  Text(
                    '₹7,500',
                    style: GoogleFonts.mukta(fontSize: 30, color: Colors.white),
                  )
                ],
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF61A3FE), Color(0xFF63FFD5)],
                    begin: Alignment.topRight,
                    end: Alignment.topLeft),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                    topLeft: Radius.circular(70))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Income",
                      style: GoogleFonts.quicksand(
                          fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      "₹20,000",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                VerticalDivider(
                  color: Colors.white,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Expenses",
                      style: GoogleFonts.quicksand(
                          fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      "₹10,000",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF61A3FE), Color(0xFF63FFD5)],
                    begin: Alignment.topRight,
                    end: Alignment.topLeft)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(70),
                        topLeft: Radius.circular(70),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 40, top: 30),
                          child: Text(
                            "Recent",
                            style: GoogleFonts.balooTammudu(
                                fontSize: 20,
                                color: Colors.black38,
                                letterSpacing: 1.5),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          indent: 40,
                          endIndent: 40,
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  TransactionCard(
                                      'Travel', 300, KoukiconsSend2(), true),
                                  TransactionCard(
                                      'Movie', 500, KoukiconsFilmReel(), true),
                                  TransactionCard(
                                      'Paytm', 750, KoukiconsSend2(), false),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class TransactionCard extends StatelessWidget {
  TransactionCard(this.title, this.amount, this.icon, this.isSpent);

  String title;
  double amount;
  var icon;
  bool isSpent;

  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: icon,
            title: Text(
              title,
              style: GoogleFonts.quicksand(
                fontSize: 15,
              ),
            ),
            trailing: isSpent
                ? Text(
                    "₹ -$amount",
                    style: GoogleFonts.mukta(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
                  )
                : Text(
                    "₹ $amount",
                    style: GoogleFonts.mukta(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
          ),
        ],
      ),
    );
  }
}
