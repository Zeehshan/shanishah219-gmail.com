


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services extends ChangeNotifier{


  addCamera()async{



  }
  List<CameraModel> listCameraModel = [];
  getAllCamera(json,id,{bool isFromMain = false})async{
    if(isFromMain == true){
      listCameraModel.add(CameraModel.fromJson(json,id));
      notifyListeners();
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      SharedPreferences.getInstance().then((res){
        if(res.getStringList("cameras") != null){
          var list = res.getStringList("cameras");
          bool check = list.where((check) => check == id).toList().isNotEmpty ? true : false;
          if(check == true){
          }else{
            listCameraModel.add(CameraModel.fromJson(json,id));
            notifyListeners();
            res.setStringList("cameras", list..add(id));
          }
        }else{
          listCameraModel.add(CameraModel.fromJson(json,id));
          notifyListeners();
          res.setStringList("cameras", []..add(id));
        }
      });
    }

  }
}

class CameraModel{
  final String id;
  final String name;
  final String pass;
  final dynamic photos;
  final SettingClass Settings;
  CameraModel({this.id,this.name,this.pass,this.photos,this.Settings});
  factory CameraModel.fromJson(json,id){
    return CameraModel(
      id: id,
      name: json["Name"],
      pass: json["Pass"].toString(),
      photos: json["Photos"],
      Settings: SettingClass.fromJson(json["Settings"])
    );
  }
}

class SettingClass{
  final String Time_To_Sleep;
  final String Upload_Time;
  final String cam_mod;

  SettingClass({this.Time_To_Sleep, this.Upload_Time, this.cam_mod});

  factory SettingClass.fromJson(json){
    return SettingClass(
      Time_To_Sleep: json["Time_To_Sleep"],
      Upload_Time: json["Upload_Time"],
      cam_mod: json["cam_mod"],
    );
  }
}