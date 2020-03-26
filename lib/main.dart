import 'package:aqib_freelancer/playing_images.dart';
import 'package:aqib_freelancer/services/bloc_pattern.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_cameradialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _serviceApp = Services();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Services>.value(value: _serviceApp),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((res){
      if(res.get("cameras") != null){
        res.getStringList("cameras").forEach((res){
          print(res);
          var _firebaseRef = FirebaseDatabase().reference();
          _firebaseRef.child(res).once().then((snapShot){
            print(snapShot.value);
            Provider.of<Services>(context,listen: false).getAllCamera(snapShot.value,snapShot.key,isFromMain: true);
          });
        });
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Services>(context);
    Size s = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            RawMaterialButton(
              onPressed: (){
                showDialog(context: context,
                barrierDismissible: false,
                builder: (context){
                  return AddingCamera();
                }
                );
              },
              child: Container(
                padding: EdgeInsets.only(left: 10),
                width: s.width,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 2)
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                        width: 30,
                        height: 30,
                        child: Image.asset("assets/camerra.png")),
                    SizedBox(width: 10,),
                    Text("Add Camera",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                  ],
                ),
              ),
            ),
            data.listCameraModel.isEmpty ? Container() :Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(data.listCameraModel.length, ((index){
                    return Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: s.longestSide/14,
                                height: s.longestSide/14,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(
                                  child: Icon(Icons.camera_enhance),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PlayingImagesClass(data.listCameraModel[index])));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(data.listCameraModel[index].name),
                                      SizedBox(height: 10,),
                                      Text(data.listCameraModel[index].id??""),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(Icons.settings,color: Colors.black,),
                                    onPressed: (){},
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(Icons.calendar_today,color: Colors.black,),
                                    onPressed: (){},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: s.width,
                          height: 1,
                          color: Colors.grey,
                        ),
                      ],
                    );
                  }))
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


