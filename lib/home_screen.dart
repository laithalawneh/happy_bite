import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_bite/Add_donationscreen.dart';
import 'package:happy_bite/my_donations.dart';
import 'profile_screen.dart';
import 'package:happy_bite/service/constant.dart';
import 'package:happy_bite/widgets/NavDrawer.dart';
import 'package:happy_bite/widgets/my_header.dart';
import 'package:awesome_button/awesome_button.dart';


class home_screen extends StatefulWidget {
  @override
  _home_screenState createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            elevation: 15.0,
            backgroundColor: kPrimaryColor,
            title: Center(
                child: Text(
              'Happy Bite      ',
            )),
          ),
          body:
          SingleChildScrollView(
            controller: controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MyHeader('images/foodbank.jpg','',240),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: AwesomeButton(
                    blurRadius: 30.0,
                    splashColor: Color.fromRGBO(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(45),
                    height: 65.0,
                    width: 220.0,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){return Add_donation_screen();}));
                    },
                    color: kPrimaryColor,

                    child : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(Icons.add , size: 35, color: kTitleTextColor,),
                        ),
                        Text('Add donation', style: TextStyle(fontSize: 19 , color: kBackgroundColor ),)

                      ],
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: AwesomeButton(
                    blurRadius: 30.0,
                    splashColor: Color.fromRGBO(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(45),
                    height: 65.0,
                    width: 220.0,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){return MyDonation_screen();}));

                    },
                    color: kPrimaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_shopping_cart, size: 30, color: kTitleTextColor,),
                        Text('My donations', style: TextStyle(fontSize: 20 , color: kBackgroundColor ),)

                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: AwesomeButton(
                    blurRadius: 30.0,
                    splashColor: Color.fromRGBO(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(45),
                    height: 65.0,
                    width: 220.0,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){return profilescreen();}));

                    },
                    color: kPrimaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.account_circle, size: 35, color: kTitleTextColor,),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Edit profile', style: TextStyle(fontSize: 20 , color: kBackgroundColor ),),
                        )

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),



              ],
            ),
          )),
    );
  }
}

