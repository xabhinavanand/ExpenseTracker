import 'package:google_fonts/google_fonts.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'main.dart';
import 'package:flutter/material.dart';
class AnalyticPage extends StatefulWidget {
  @override
  _AnalyticPageState createState() => _AnalyticPageState();
}

class _AnalyticPageState extends State<AnalyticPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff17395c),
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.amber,
            tabs: [
              new Tab(text: "Month",),
              new Tab(
                text: "Week",
              ),
              new Tab(
                text: "Day",
              )
            ],
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          bottomOpacity: 1,
        ),
        body: TabBarView(
          children: [
            new Text("This is call Tab View"),
            new Text("This is chat Tab View"),
            new Text("This is notification Tab View"),
          ],
          controller: _tabController,
        ),
        backgroundColor: Color(0xff17395c),
      ),
    );
  }
}
