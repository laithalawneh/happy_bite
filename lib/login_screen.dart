import 'widgets/LoginCard.dart';
import 'widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'Registration_screen.dart';

class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyHeader('images/login_image.jpg','Happy Bite',183),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    loginCard(),

                    SizedBox(
                      height: 40.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'New User? ',
                          style: TextStyle(
                              fontFamily: 'Poppins-Medium', fontSize: 18.0),
                        ),
                        InkWell(
                          onTap: () {

                            Navigator.push(context, MaterialPageRoute(builder: (context){return Registration_screen();}));
                          },
                          child: Text('SignUp',
                              style: TextStyle(
                                  color: Color(0xFF5d74e3),
                                  fontSize: 18.0,
                                  fontFamily: 'Poppins-Bold')),
                        )
                      ],
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
