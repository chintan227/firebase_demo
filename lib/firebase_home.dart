import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirebaseHome extends StatefulWidget {
  const FirebaseHome({Key? key}) : super(key: key);

  @override
  State<FirebaseHome> createState() => _FirebaseHomeState();
}

class _FirebaseHomeState extends State<FirebaseHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: FutureBuilder(future: getData(),builder: (context, snapshot) {
          Map data = snapshot.data as Map;
          List user = data["users"];
          List study = data["Study"];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 300,
                child: ListView.builder(shrinkWrap: true,itemCount: user.length,itemBuilder: (context, index) {
                  if(user[index] == null){
                    return Container();
                  }
                  if(study[index] == null){
                    return Container();
                  }
                  return Text("name =$index= ${user[index]["name"]}--${user[index]["age"]}-${study[index]["degree"]}- ${study[index]["College"]}");
                },),
              ),
              RaisedButton(onPressed: (){insert();},child: Text("Insert")),
              RaisedButton(onPressed: (){update();},child: Text("Update")),
              RaisedButton(onPressed: (){getData();},child: Text("Get Data")),
            ],
          );
        },)


      )),
    );
  }

  insert() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Study").child("2");
    await ref.set({
     "degree":"BCA",
      "College":"Sutex Bank College"
    }).whenComplete(() {print("Done");});
  }

  update() async{
    DatabaseReference ref = FirebaseDatabase.instance.ref("users").child("1");
    await ref.update({
      "name": "chintan",
      "age": 22,
      "address": {
        "line1": "Simada"
      }
    }).whenComplete(() {print("Done");});
  }

  Future getData() async{
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.get();
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      print('No data available.');
    }
    return snapshot.value;
  }
}
