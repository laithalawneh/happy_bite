import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_bite/service/constant.dart';
import 'package:happy_bite/login_screen.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
           DrawerHeader(
            decoration: BoxDecoration(
                color: kPrimaryColor,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/fooddonations_0.gif'),
                )), child: null,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              size: 40,
            ),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>loginScreen()),(route) => false);
            },
          ),
        ],
      ),
    );
  }
}
