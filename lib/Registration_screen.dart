import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'Registration_screen2.dart';
import 'package:happy_bite/service/constant.dart';
import 'widgets/my_header.dart';
import 'package:http/http.dart' as http;

class Registration_screen extends StatefulWidget {
  @override
  _Registration_screenState createState() => _Registration_screenState();
}

class _Registration_screenState extends State<Registration_screen> {
  final controller = ScrollController();
  String FirstName;
  String lastName;
  String email;
  String User_Name;
  String password;
  String re_password;
  var res;


  void post_user_info(String Email, String Username, String First_name,
      String Last_name, String Password, String Password2) {
    print('===================Data=====================');
    String url = "http://68.183.215.61/api/signup";
      http.post(url, body: {
      "email": Email,
      "username": Username,
      "first_name": First_name,
      "last_name": Last_name,
      "password": Password,
      "password2": Password2
    }).then((response){
      res = response.body;
      rejest_Res rej=rejest_ResFromJson(res);
      id_user=rej.id;
      if(res.contains("successful")){
        print(res.toString());
        Navigator.push(context,MaterialPageRoute(builder: (context) => Registration_screen2()));
      }
      else
      {
        Alert(
          context: context,
          type: AlertType.error,
          title: 'Registration not Complet',
        ).show();
      }

    });
    print('==================Post=====================');

  }

  void finshed_registration() {
    setState(() {
      if (FirstName != null &&
          lastName != null &&
          email != null &&
          User_Name != null &&
          password != null &&
          re_password != null &&
          re_password == password) {
        post_user_info(
            email, User_Name, FirstName, lastName, password, re_password);
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: 'Registration not Complet',
          desc: 'please make sure to enter all information correctly',
        ).show();
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: <Widget>[
              MyHeader('images/How-to-Donate-to-the-Food-Pantries-of-Tampa-FL_b.jpg','',150),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        style: TextStyle(color: kTitleTextColor, height: 0.8),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kShadowColor,
                          hintText: 'First Name',
                          hintStyle: TextStyle(color: kTextLightColor),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                        ),
                        onChanged: (value) {
                          FirstName = value;
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        style: TextStyle(color: kTitleTextColor, height: 0.8),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kShadowColor,
                          hintText: 'last Name',
                          hintStyle: TextStyle(color: kTextLightColor),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                        ),
                        onChanged: (value) {
                          lastName = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 6.0, bottom: 10),
                child: TextField(
                  style: TextStyle(color: kTitleTextColor, height: 0.8),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kShadowColor,
                    hintText: 'email',
                    hintStyle: TextStyle(color: kTextLightColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 6.0, bottom: 10),
                child: TextField(
                  style: TextStyle(color: kTitleTextColor, height: 0.8),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kShadowColor,
                    hintText: 'User Name',
                    hintStyle: TextStyle(color: kTextLightColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onChanged: (value) {
                    User_Name = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 6.0, bottom: 10),
                child: TextField(
                  maxLength: 12,
                  style: TextStyle(color: kTitleTextColor, height: 0.8),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kShadowColor,
                    hintText: 'password',
                    hintStyle: TextStyle(color: kTextLightColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10),
                child: TextField(
                  maxLength: 12,
                  style: TextStyle(color: kTitleTextColor, height: 0.8),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kShadowColor,
                    hintText: 'Re-password',
                    hintStyle: TextStyle(color: kTextLightColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onChanged: (value) {
                    re_password = value;
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 95, right: 95, bottom: 30),
                  child: RaisedButton(
                    highlightElevation: 10,
                    splashColor: kPrimaryColor,
                    elevation: 13,
                    color: kPrimaryColor,
                    onPressed: ()  {
                      setState((){
                        finshed_registration();
                      });
                    },
                    child: Center(
                        child: Text('continue',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins-Bold',
                                fontSize: 40,
                                letterSpacing: 2.0))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

rejest_Res rejest_ResFromJson(String str) => rejest_Res.fromJson(json.decode(str));

String rejest_ResToJson(rejest_Res data) => json.encode(data.toJson());

class rejest_Res {
  rejest_Res({this.id});
  int id;

  factory rejest_Res.fromJson(Map<String, dynamic> json) => rejest_Res(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}