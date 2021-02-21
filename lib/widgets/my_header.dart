
import 'package:happy_bite/service/constant.dart';
import 'package:flutter/material.dart';

class MyHeader extends StatefulWidget {
   String imagee;
   String text;
   double Height;

   MyHeader(this.imagee, this.text, this.Height);

  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 40, top: 50, right: 20),
        height: widget.Height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF3383CD),
              Color(0xFF11249F),
            ],
          ),

          image: DecorationImage(

            fit: BoxFit.cover,
            image: AssetImage(widget.imagee),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 30),
            Expanded(
              child: Stack(
                children: <Widget>[

                  Positioned(
                    top: 70 ,
                    left: 200,
                    child: Text(
                      '${widget.text}',
                      style: kHeadingTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 3, size.height +16, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {

    return false;
  }
}
