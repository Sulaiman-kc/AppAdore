import 'package:flutter/material.dart';
import '../Home.dart';
import '../models/data_models.dart';
typedef ColorCallback = void Function();

class BusinessPage extends StatefulWidget {
  @override
  _BusinessPageState createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  List data;
  dynamic mycolor = Colors.white;
  // bool isSelected = false;
  @override
  void initState() {
    print(isSelected);
    print('hello');
    // TODO: implement initState
    DataModel().fetchUsers().then((value) {
      setState(() {
        this.data = value;//.where((i) => i['image'] = null);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    isSelected = true;
                    if(this.data[i]["isSelected"] == null || this.data[i]["isSelected"] == false)
                      this.data[i]["isSelected"] = true;
                    else
                      this.data[i]["isSelected"] = false;
                  });
                },//this.toggleSelection
              onTap: () {
                setState(() {
                  isSelected = true;
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
  toggleSelection() {
    print('');

    // setState(() {
    //   if (this.isSelected) {
    //     this.mycolor=Colors.white;
    //     this.isSelected = false;
    //   } else {
    //     this.mycolor=Colors.grey[300];
    //     this.isSelected = true;
    //   }
    // });
  }
}
