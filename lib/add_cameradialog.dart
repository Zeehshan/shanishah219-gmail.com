import 'package:aqib_freelancer/services/bloc_pattern.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class AddingCamera extends StatefulWidget {
  @override
  _AddingCameraState createState() => _AddingCameraState();
}

class _AddingCameraState extends State<AddingCamera> {
  final _formKey = GlobalKey<FormState>();
  String _cameraName;
  String _password;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Services>(context);
    Size s = MediaQuery.of(context).size;
    return Dialog(
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: s.height/2,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 30,
                      height: 30,
                      child: Image.asset("assets/camerra.png")),
                  SizedBox(width: 10,),
                  Text("Create New Camera"),
                ],
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Add new Camera",
                  labelText: "Camera Id"
                ),
                validator: (s){
                  if(s.isEmpty)
                    return "Required*";
                  return null;
                },
                onSaved: (s){
                  _cameraName = s;
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter password",
                  labelText: "Password"
                ),
                validator: (s){
                  if(s.isEmpty)
                    return "Required*";
                  return null;
                },
                onSaved: (s){
                  _password = s;
                },
              ),
             Spacer(),
              loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),)):Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    color: Colors.red,
                    child: Text("Cancel",style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    color: Colors.green,
                    child: Text("Add Camera",style: TextStyle(color: Colors.white),),
                    onPressed: ()async{
                      FocusScope.of(context).requestFocus(FocusNode());
                      final FormState form = _formKey.currentState;
                      if (!form.validate()) {}
                      else{
                        form.save();
                        try{
                          setState(() {
                            loading = true;
                          });
                          print("okay");
                          print(_cameraName);
                          var _firebaseRef = FirebaseDatabase().reference();
                          _firebaseRef.child(_cameraName).once().then((res){
                            if(res.value == null){
                              setState(() {
                                loading = false;
                              });
                              Toast.show("Incorect Camera id",context,duration: Toast.LENGTH_LONG);
                            }else{
                              if(_password == res.value["Pass"].toString()){
                                print("okayokay");
                                data.getAllCamera(res.value,res.key);
                                Navigator.pop(context);
                                setState(() {
                                  loading = false;
                                });
                              }else{
                                setState(() {
                                  loading = false;
                                });
                                Toast.show("Incorect password",context,duration: Toast.LENGTH_LONG);
                              }
                            }
                          }).catchError((err) => print(err));
                        }catch(e){
                          print(e);
                        }
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
