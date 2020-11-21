import 'dart:math';

import 'package:appadore/pages/business.dart';
import 'package:appadore/pages/calls.dart';
import 'package:appadore/pages/huddles.dart';
import 'package:appadore/pages/personal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/data_models.dart';


class AppAdoreHomePage extends StatefulWidget {
  @override
  _AppAdoreHomePageState createState() => _AppAdoreHomePageState();
}

class _AppAdoreHomePageState extends State<AppAdoreHomePage>
    with SingleTickerProviderStateMixin  {
  TabController _tabController;
  @override
  void initState() {
    print('object');
    // DataModel().fetchUsers().then((value) => {
    //   print((value[0]))
    // });
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this,initialIndex: 1,length: 4);
  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("AppAdore"),
      //   elevation: 0.7,
      //   bottom: TabBar(
      //     controller: _tabController,
      //     indicatorColor: Colors.white,
      //     tabs: [
      //       Tab(text: "PERSONAL",),
      //       Tab(text: "BUSINESS",),
      //       Tab(text: "HUDDLES",),
      //       Tab(text: "CALLS",),
      //     ],
      //   ),
      //   actions: [
      //     Icon(Icons.search),
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 5.0),
      //     ),
      //     Icon(Icons.more_vert)
      //   ],
      // ),
        body: NestedScrollView(
        // controller: _tabController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          new SliverAppBar(
            title: Text('AppAdore'),
            pinned: true,
            floating: true,
            forceElevated: innerBoxIsScrolled,
            bottom: new TabBar(
              tabs: <Tab>[
                Tab(text: "PERSONAL",),
                Tab(text: "BUSINESS",),
                Tab(text: "HUDDLES",),
                Tab(text: "CALLS",),
              ],
              controller: _tabController,
            ),
            actions: [
              Icon(Icons.search),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
              ),
              Icon(Icons.more_vert)
            ],
          ),
        ];
      },
          body: TabBarView(
        controller: _tabController,
        children: [
          PersonalPage(),
          BusinessPage(),
          HuddlesPage(),
          CallsPage(),
        ],
      ),
        )
    );
  }
}
