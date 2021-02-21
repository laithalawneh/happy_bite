import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;
import 'widgets/my_header.dart';
import 'package:happy_bite/service/constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Add_donation_screen extends StatefulWidget {
  @override
  _Add_donation_screenState createState() => _Add_donation_screenState();
}

class _Add_donation_screenState extends State<Add_donation_screen> {
  final controller = ScrollController();
  String type_Food;
  String donation_details;
  String ex_date;
  String location_lat;
  String location_long;
  String Packed;
  String Deliver;
  var res;
  Color D_icon_Color = Color(0xFF303030);
  Color P_icon_Color = Color(0xFF303030);

  void post_data() async{
    print('===================Data=====================');
    String url = "http://68.183.215.61/donation/api/add";
    await http.post(url,
        headers: {
          "content-type": "application/json",
        },
        body:jsonEncode(
        {
      "donor": id_user,
      "Name": type_Food,
      "description": donation_details,
      "Packing_Type": Packed,
      "Deliver_Type": Deliver,
      "Expiry_Date": ex_date,
      "lang": location_long,
      "lat": location_lat
    }));
    print('==================Post=====================');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home_screen()));

  }

  DateTime _dateTime = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime expiration_day = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2020),
        lastDate: DateTime(2050));
    if (expiration_day != null && expiration_day != _dateTime) {
      setState(() {
        _dateTime = expiration_day;
        ex_date = _dateTime.toIso8601String();
        print(ex_date);
      });
        print(ex_date);
    }
  }

  void get_location() async{
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    setState(() {
      location_lat=position.latitude.toString();
      location_long=position.longitude.toString();
    });
    print(location_lat);
    print(location_long);
    print(location_lat);
    print(location_long);
  }

  void finshed_donation() {
    setState(() {
      if (type_Food != null && donation_details != null && ex_date != null && Packed != null && Deliver != null)
      {
        post_data();
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: 'not Complet',
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyHeader('images/fooddonations_0.gif','',190),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextField(
                  maxLength: 20,
                  style: TextStyle(color: kTitleTextColor, height: 0.8),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kShadowColor,
                    hintText: 'type of Food',
                    hintStyle: TextStyle(color: kTextLightColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onChanged: (value) {
                    type_Food = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: TextField(
                  maxLines: 5,
                  style: TextStyle(color: kTitleTextColor, height: 0.8),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kShadowColor,
                    hintText: 'Additional donation details ',
                    hintStyle: TextStyle(color: kTextLightColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onChanged: (value) {
                    donation_details = value;
                  },
                ),
              ),

              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                      value: "Packed",
                      groupValue: Packed,
                      onChanged: (value){
                        setState(() {
                          Packed=value;
                        });
                      }
                  ),
                  Text(
                    'Packed    ',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: kBodyTextColor),
                  ),

                  SizedBox(
                    width: 20,
                  ),

                  Radio(
                      value: "Not Packed",
                      groupValue: Packed,
                      onChanged: (value){
                        setState(() {
                          Packed=value;
                        });
                      }),
                  Text(
                    'Not Packed',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: kBodyTextColor),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                      value: "Delivery",
                      groupValue: Deliver,
                      onChanged: (value){
                        setState(() {
                          Deliver=value;
                        });
                      }),
                  Text(
                    'I can deliver',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: kBodyTextColor),
                  ),


                  Radio(
                      value: "No Delivery",
                      groupValue: Deliver,
                      onChanged: (value){
                        setState(() {
                          Deliver=value;

                        });
                      }),
                  Text(
                    'I can\'t deliver',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: kBodyTextColor),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      'Expiration Day',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: kBodyTextColor),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        size: 35,
                        color: D_icon_Color,
                      ),
                      onPressed: () {
                        setState(() {
                          selectDate(context);
                          D_icon_Color= Color(0xFF3382CC);
                        });

                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      'Add location',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: kBodyTextColor),
                    ),
                  ),
                  SizedBox(
                    width: 54,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      focusColor: kBodyTextColor,
                      icon: Icon(
                        Icons.place,
                        size: 35,
                        color: P_icon_Color,
                      ),
                      onPressed: () {
                        setState(() {
                          get_location();
                          P_icon_Color=  Color(0xFF3382CC);
                        });
                      },
                    ),
                  ),
                ],
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
                          post_data();
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

