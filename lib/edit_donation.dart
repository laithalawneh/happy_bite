import 'dart:convert';

import 'package:happy_bite/widgets/my_donation_h2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:happy_bite/service/constant.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'my_donations.dart';

class Edit_donation extends StatefulWidget {
   int donation_id;
  Edit_donation(this.donation_id);
  @override
  _Edit_donationState createState() => _Edit_donationState();
}

class _Edit_donationState extends State<Edit_donation> {

  final controller = ScrollController();
  String new_type_Food;
  String new_donation_details;
  String new_ex_date;
  String new_location_lat;
  String new_location_long;
  String new_Packed;
  String new_Deliver;
  var res;


  void update_data() async{
    print('===================Data=====================');
    String url = "http://68.183.215.61/donation/api/update/$id_donation";
    await http.put(url, headers: {
          "content-type": "application/json",
        },
        body:jsonEncode(
    {
      "Name": new_type_Food,
      "description": new_donation_details,
      "Packing_Type": new_Packed,
      "Deliver_Type": new_Deliver,
       "Expiry_Date": new_ex_date,
      "lang": new_location_lat,
      "lat": new_location_long,
    })).then((response){
      res = response.body;
      if(res.contains("donation data updated")){
        print(res.toString());
        Navigator.pop(context);
        setState(() {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyDonation_screen()));
        });
      }
      else
      {
        Alert(
          context: context,
          type: AlertType.error,
          title: 'Update not Complet',
        ).show();
      }

    });
    print('==================Post=====================');
  }

  void get_location() async{
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      new_location_lat=position.latitude.toString();
      new_location_long=position.longitude.toString();
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
        new_ex_date = _dateTime.toIso8601String();
        print(new_ex_date);
      });
      print(new_ex_date);
    }
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
              my_donations_Header(),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0,top: 25.0),
                child: TextField(
                  maxLength: 20,
                  style: TextStyle(color: kTitleTextColor, height: 0.8),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kShadowColor,
                    hintText: 'new donation name',
                    hintStyle: TextStyle(color: kTextLightColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onChanged: (value) {
                    new_type_Food = value;
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
                    hintText: 'new Additional details for donation ',
                    hintStyle: TextStyle(color: kTextLightColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onChanged: (value) {
                    new_donation_details = value;
                  },
                ),
              ),

              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                      value: "Packed",
                      groupValue: new_Packed,
                      onChanged: (value){
                        setState(() {
                          new_Packed=value;
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
                      groupValue: new_Packed,
                      onChanged: (value){
                        setState(() {
                          new_Packed=value;
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
                      groupValue: new_Deliver,
                      onChanged: (value){
                        setState(() {
                          new_Deliver=value;
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
                      groupValue: new_Deliver,
                      onChanged: (value){
                        setState(() {
                          new_Deliver=value;

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
                      ),
                      onPressed: () {
                        setState(() {
                          selectDate(context);
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
                      ),
                      onPressed: () {
                        setState(() {
                          get_location();
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

                          update_data();
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
