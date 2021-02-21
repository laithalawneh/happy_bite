import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'login_screen.dart';
import 'package:happy_bite/service/constant.dart';
import 'widgets/my_header.dart';

class Registration_screen2 extends StatefulWidget {
  @override
  _Registration_screen2State createState() => _Registration_screen2State();
}

class _Registration_screen2State extends State<Registration_screen2> {
  final controller = ScrollController();

  String type_of_User;
  String address;
  String phone_number;


  void update_data() async{
    print('===================Data=====================');
    String url = "http://68.183.215.61/api/donorprofileupdate/$id_user";
    await http.put(url, headers: {
      "content-type": "application/json",
    },
        body:jsonEncode(
            {
              "Donar_Employment_Type": type_of_User,
              "Donor_Phone_Number": phone_number,
              "address": address,

            }));
    print('==================Post=====================');
  }

  void finshed_registration() {
      if (type_of_User != null && address !=null && phone_number !=null ) {
        update_data();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginScreen()));
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: 'Registration not Complet',
          desc: 'please make sure to enter all information correctly' ,
          buttons: [
            DialogButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
              width: 120,
            )
          ],
        ).show();
      }
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
              Padding(
                padding:EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0, bottom: 10),
                child: TextField(
                  maxLength: 10,
                  style: TextStyle(color: kTitleTextColor, height: 0.8),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kShadowColor,
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: kTextLightColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onChanged: (value) {
                    String n =value.substring(1);
                    phone_number = "+962$n";
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 10),
                child: TextField(
                  style: TextStyle(color: kTitleTextColor, height: 0.8),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kShadowColor,
                    hintText: 'type of User',
                    hintStyle: TextStyle(color: kTextLightColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onChanged: (value) {
                    type_of_User = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0 ,top: 6.0, bottom: 10),
                child: TextField(
                  style: TextStyle(color: kTitleTextColor, height: 0.8),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kShadowColor,
                    hintText: ' address',
                    hintStyle: TextStyle(color: kTextLightColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onChanged: (value) {
                    address = value;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: kPrimaryColor,
                      onPressed: () {
                        setState(() {
                          finshed_registration();
                        });
                      },
                      child: Center(
                          child: Text('save',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins-Bold',
                                  fontSize: 20,
                                  letterSpacing: 2.0))),
                    ),
                    SizedBox(
                      width: 60,
                    ),

                    RaisedButton(
                      color: kPrimaryColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                          child: Text('back',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins-Bold',
                                  fontSize: 20,
                                  letterSpacing: 2.0))),
                    )

                  ],

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
