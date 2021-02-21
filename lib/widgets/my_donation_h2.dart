import 'package:flutter/material.dart';
import 'package:happy_bite/service/constant.dart';

class my_donations_Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      child: Padding(
        padding: const EdgeInsets.only(top: 48.0, left: 30),
        child: Text(
          "Edit My Donation",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(46),
          bottomLeft: Radius.circular(46),
        ),
      ),
    );
  }
}
