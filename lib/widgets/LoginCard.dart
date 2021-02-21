import 'package:flutter/material.dart';
import 'package:happy_bite/service/constant.dart';
import 'package:happy_bite/home_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';



class loginCard extends StatefulWidget
{
  @override
  _loginCardState createState() => _loginCardState();
}
class _loginCardState extends State<loginCard> {
  @override
  TextEditingController password_Controller = TextEditingController();
  bool passwordInvisible = true;
  String Username;
  String password;
  var res2;
  var login_status;

  void post_data(String Username, String password)async{
    print('===================Data=====================');
    String url = "http://68.183.215.61/api/login";
    await http.post(url, body:{
      "username": Username,
      "password": password,
    }).then((response) async {
      res2 = response.body;
      login_status = res2.contains("token");
      LoginRes USER = loginResFromJson(res2);
      id_user = USER.id;
      if(login_status)
      {
        print(res2.toString());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home_screen()));
      }
      else
      {
        Alert(
          context: context,
          type: AlertType.error,
          title: 'login not Complet',
          desc: 'user name / password is wrong',
          buttons: [
            DialogButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
              width: 100,
            )
          ],
        ).show();
      }

    });
    print('==================Post=====================');
    print(id_user);
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: new Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 1),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 15.0),
                  blurRadius: 15.0),
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, -15.0),
                  blurRadius: 10.0),
            ]),
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text('Welcome',
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Poppins-Bold',
                        color: kPrimaryColor,
                        letterSpacing: .4)),
              ),
              SizedBox(
                height: 25,
              ),
              Text('Username',
                  style:
                      TextStyle(fontFamily: 'Poppins-BlackItalic', fontSize: 26)),
              TextField(
                decoration: InputDecoration(
                    hintText: '',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                onChanged: (value) {
                  Username = value;

                },
              ),
              SizedBox(
                height: 30,
              ),
              Text('PassWord',
                  style:
                      TextStyle(fontFamily: 'Poppins-BlackItalic', fontSize: 26)),
              TextFormField(
                controller: password_Controller,
                obscureText: passwordInvisible,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordInvisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordInvisible = !passwordInvisible;

                        });
                      },
                    ),
                    hintText: '**********',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 35,
              ),

              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                            color: kActiveShadowColor,
                            offset: Offset(0.0, 10.0),
                            blurRadius: 8.0)]),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: ()async{
                        password = password_Controller.text;
                        post_data(Username, password);

                      },
                      child: Center(
                        child: Text('SIGNIN',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins-Bold',
                                fontSize: 30,
                                letterSpacing: 4.0)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }


}

LoginRes loginResFromJson(String str) => LoginRes.fromJson(json.decode(str));

String loginResToJson(LoginRes data) => json.encode(data.toJson());

class LoginRes {
  LoginRes({
    this.token,
    this.id,
  });

  String token;
  int id;

  factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
    token: json["token"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "id": id,
  };
}
