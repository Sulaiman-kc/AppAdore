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
  bool isS;
  List data;
  List ids = [];
  @override
  void initState() {
    print('object');
    setState(() {
      this.isS = false;
    });
    DataModel().fetchUsers().then((value) {
      setState(() {
        this.data = value;//.where((i) => i['image'] = null);
      });
    });
    print('this.isS');
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this,initialIndex: 1,length: 4);
  }

  select(){
    this.isS = !this.isS;
    print(this.isS);
  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: this.isS?NestedScrollView(
        // controller: _tabController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          new SliverAppBar(
            // title: Text('AppAdore'),
            pinned: true,
            floating: false,
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
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.backspace),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.pin_drop),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.volume_off),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_forever),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.archive),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    // Icon(Icons.more_vert),
                    // Icon(Icons.archive),
                    // Icon(Icons.more_vert),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 5.0),
              // ),
              // Icon(Icons.search),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 5.0),
              // ),
              // Icon(Icons.more_vert),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 5.0),
              // ),
            ],
          ),
        ];
      },
          body: TabBarView(
        controller: _tabController,
        children: [
          chatCard(),
          chatCard(),
          chatCard(),
          chatCard(),
        ],
      ),
        ):NestedScrollView(
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
        chatCard(),
        chatCard(),
        chatCard(),
        chatCard(),
      ],
      ),
      )
    );
  }
  Widget chatCard(){
    return ListView.builder(
      itemCount: (this.data == null)?0:20,
      itemBuilder: (context,i)=>Container(
        color: (this.data[i]['isSelected'] == null ||this.data[i]['isSelected'] == false)? Colors.white:Colors.greenAccent[100],
        child: Column(
          children: [
            Divider(
              height: 10.0,
            ),
            ListTile(
              // selected: this.isSelected,
              leading: CircleAvatar(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(this.data[i]["image"]),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    this.data[i]["name"],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    this.data[i]["dod"],
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                ],
              ),
              subtitle: Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  this.data[i]["note"],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 15.0),
                ),
              ),
              onLongPress: () {
                print(i);
                setState(() {
                  this.isS = true;
                  if(this.data[i]["isSelected"] == null || this.data[i]["isSelected"] == false){
                    this.data[i]["isSelected"] = true;
                  }
                  else
                    this.data[i]["isSelected"] = false;
                  if(this.ids.contains(this.data[i]['_id']))
                    this.ids.remove(this.data[i]['_id']);
                  else
                    this.ids.add(this.data[i]['_id']);
                  if(this.ids.length == 0)
                    this.isS = false;
                  else
                    this.isS = true;
                });
              },//this.toggleSelection
              onTap: () {
                setState(() {
                  if(this.ids.contains(this.data[i]['_id'])){
                    this.ids.remove(this.data[i]['_id']);
                  }
                  if(this.ids.length == 0)
                    this.isS = false;
                  else
                    this.isS = true;
                  this.data[i]["isSelected"] = false;
                });
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AppAdoreHomePage()),
                // );
                // Navigator.pop(context);
                print(isSelected);
              },
            ),
          ],
        ),
      ),
    );
  }
}
