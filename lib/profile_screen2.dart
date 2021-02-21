import 'dart:convert';
import 'package:happy_bite/service/constant.dart';
import 'widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class profilescreen2 extends StatefulWidget {
  @override
  _profilescreen2State createState() => _profilescreen2State();
}

class _profilescreen2State extends State<profilescreen2> {
  final controller = ScrollController();
  String old_type_of_employment;
  String old_phone_number;
  String old_adress;
  String new_type_of_employment;
  String new_phone_number;
  String new_adress;

  @override
  void initState() {
      get_oldData();
    super.initState();
  }

  void get_oldData() async{
    var data = await http.get("http://68.183.215.61/api/donorprofile/$id_user");
    var jsondata=jsonDecode(utf8.decode(data.bodyBytes));
    setState(() {
      old_phone_number=jsondata["Donor_Phone_Number"];
      old_type_of_employment=jsondata["Donar_Employment_Type"];
      old_adress=jsondata["address"];
    });
    new_phone_number=old_phone_number;
    new_adress=old_adress;
    new_type_of_employment=old_type_of_employment;
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
  }

  void update_data() async{
    print('===================Data=====================');
    String url = "http://68.183.215.61/api/donorprofileupdate/$id_user";
    await http.put(url, headers: {
      "content-type": "application/json",
    },
        body:jsonEncode(
            {
              "Donar_Employment_Type": new_type_of_employment,
              "Donor_Phone_Number": new_phone_number,
              "address": new_adress

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
                MyHeader("","",130),
                Text('Edit profile' , style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,),),

                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: TextField(
                    maxLength: 10,
                    style: TextStyle(color: kTitleTextColor, height: 0.8),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kShadowColor,
                      hintText: old_phone_number,
                      hintStyle: TextStyle(color: kTextLightColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                    onChanged: (value) {
                          String n =value.substring(1);
                          new_phone_number = "+962$n";
                    },
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: TextField(
                    maxLength: 12,
                    style: TextStyle(color: kTitleTextColor, height: 0.8),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kShadowColor,
                      hintText: old_type_of_employment,
                      hintStyle: TextStyle(color: kTextLightColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                    onChanged: (value) {
                      new_type_of_employment = value;
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
                      hintText: old_adress,
                      hintStyle: TextStyle(color: kTextLightColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                    onChanged: (value) {
                      new_adress = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only( top: 10,left: 15.0, right: 11.0),
                  child: Text('When you finish entering data,\n '
                      'Please press save to update your new information.' , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: kPrimaryColor),),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: kPrimaryColor,
                        onPressed: () {
                          update_data();
                          Navigator.pop(context)  ;
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
          )),
    );
  }
}
