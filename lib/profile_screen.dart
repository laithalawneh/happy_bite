import 'dart:convert';

import 'package:awesome_button/awesome_button.dart';
import 'package:happy_bite/profile_screen2.dart';
import 'package:happy_bite/service/constant.dart';
import 'widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class profilescreen extends StatefulWidget {
  @override
  _profilescreenState createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen> {
  final controller = ScrollController();
  String old_FirstName;
  String old_lastName;
  String old_email;
  String old_User_Name;
  String new_FirstName;
  String new_lastName;
  String new_email;
  String new_User_Name;

  @override
  void initState() {
    get_oldData();
    super.initState();
  }

  void get_oldData() async{
    var data = await http.get("http://68.183.215.61/api/userprofile/$id_user");
    var jsondata=jsonDecode(utf8.decode(data.bodyBytes));
    setState(() {
      old_FirstName=jsondata["first_name"].toString();
      old_lastName=jsondata["last_name"].toString();
      old_email=jsondata["email"].toString();
      old_User_Name=jsondata["username"].toString();
    });
    new_FirstName=old_FirstName;
    new_lastName=old_lastName;
    new_email=old_email;
    new_User_Name=old_User_Name;
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
  }

  void update_data() async{
    print('===================Data=====================');
    String url = "http://68.183.215.61/api/userupdate/$id_user";
    await http.put(url, headers: {
      "content-type": "application/json",
    },
        body:jsonEncode(
            {
              "email": new_email,
              "username": new_User_Name,
              "first_name": new_FirstName,
              "last_name": new_lastName,

            }));
    print('==================Post=====================');
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

          body: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: <Widget>[
                MyHeader("","",167),
                Text('Edit profile' , style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,),),

                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0 , bottom: 12.0),
                  child: TextField(
                    style: TextStyle(color: kTitleTextColor, height: 0.8),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kShadowColor,
                      hintText: old_FirstName,
                      hintStyle: TextStyle(color: kTextLightColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if(value==null) new_FirstName = old_FirstName;
                        else new_FirstName = value;
                      });
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0, bottom: 12.0),
                  child: TextField(
                    style: TextStyle(color: kTitleTextColor, height: 0.8),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kShadowColor,
                      hintText: old_lastName,
                      hintStyle: TextStyle(color: kTextLightColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if(value==null) new_lastName = old_lastName;
                        else new_lastName = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0, bottom: 12.0),
                  child: TextField(
                    style: TextStyle(color: kTitleTextColor, height: 0.8),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kShadowColor,
                      hintText: old_email,
                      hintStyle: TextStyle(color: kTextLightColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if(value==null) new_email = old_email;
                        else new_email = value;
                      });
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0, bottom: 12.0),
                  child: TextField(
                    maxLength: 12,

                    style: TextStyle(color: kTitleTextColor, height: 0.8),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kShadowColor,
                      hintText: old_User_Name,
                      hintStyle: TextStyle(color: kTextLightColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if(value==null) new_User_Name = old_User_Name;
                        else new_User_Name = value;
                      });
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: AwesomeButton(
                    blurRadius: 22.0,
                    splashColor: Color.fromRGBO(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(45),
                    height: 65.0,
                    width: 220.0,
                    onTap: () {
                      update_data();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>profilescreen2()));
                    },
                    color: BColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back_ios, size: 35, color: kBackgroundColor,),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('continue', style: TextStyle(fontSize: 20 , color: kBackgroundColor ),),
                        )

                      ],
                    ),
                  ),
                ),

              ],
            ),
          )),
    );
  }
}
