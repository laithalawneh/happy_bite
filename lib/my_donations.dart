import 'dart:convert';
import 'edit_donation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_bite/service/constant.dart';
import 'package:http/http.dart' as http;

class MyDonation_screen extends StatefulWidget {

  @override
  State createState() => _MyDonation_screenState();
}

class _MyDonation_screenState extends State<MyDonation_screen> {

  Future<List<donation>> get_donations() async{

    var data = await http.get("http://68.183.215.61/api/donordonation/$id_user");
    var jsondata=jsonDecode(utf8.decode(data.bodyBytes));
    List<donation>donations=[];
    for(var item in jsondata)
    {
      donation dona= donation(item["id"],item["charity"],item["Name"],item["description"],item["Packing_Type"],item["Deliver_Type"],item["Expiry_Date"],item["Available"]);
      donations.add(dona);
    }
    print(donations.length);
    return donations;
  }


   delete_conf(int id ){
      showDialog(context: context,
          builder: (BuildContext context)=>AlertDialog(
            title: Text('Delete ?'),
            actions: [
              FlatButton(
                  onPressed: ()  {
                    http.delete("http://68.183.215.61/donation/api/delete/$id");
                    setState(() {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return MyDonation_screen();}));

                    });

                  },
                  child: Text('Yes')),
              FlatButton(
                  onPressed:(){ Navigator.pop(context); }
                  , child: Text('NO')),


            ],
          )
      );

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading:false,
              centerTitle:true,
              title:Center(
                child: Text(
                  "My Donation",
                  style: TextStyle(color: Colors.white, fontSize: 33 ,fontWeight: FontWeight.bold),
                ),
              ),
              toolbarHeight: 80,
              shadowColor:kTitleTextColor,
              backgroundColor: BColor,
              elevation:75

          ),
          body: Container(
            child: FutureBuilder(
              future: get_donations(),
              builder: (context, snapShot) {
                if(snapShot.data==null || snapShot.data.length==0){
                  return Container(
                    child: Center(child: Text('don\'t have donations yet......',
                      style: TextStyle(color: Colors.white, fontSize: 35 ,fontWeight: FontWeight.bold)
                    )
                    ),
                  );
                }
                else{
                  if (snapShot.connectionState == ConnectionState.waiting ) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 25),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topRight,
                                colors: [
                                  Color(0xFF3383CD).withOpacity(.7),
                                  Color(0xFF0760DE),
                                ],
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF959595).withOpacity(0.9),
                                    blurRadius: 8,
                                    spreadRadius: 4,
                                    offset: Offset(4, 4)
                                )
                              ],
                            ),
                            child: Card(
                              elevation: 10,
                              margin: EdgeInsets.symmetric(horizontal: 13, vertical: 13),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(snapShot.data[index].Name.toString(),
                                          style: TextStyle(
                                              fontSize: 30, color: Color(0xFF3382CC))),
                                    ),

                                    Text(snapShot.data[index].description.toString(),
                                        style: TextStyle(
                                            fontSize: 18)),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:<Widget>[
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Packaging status:", style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color:BColor)),
                                            Text(snapShot.data[index].Packing_Type,
                                                style: TextStyle(
                                                    fontSize: 15, color: Color(0xFF303030))),                                          ],
                                        ),
                                        SizedBox(width: 46),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Delivery status:" ,style: TextStyle(fontSize: 13,color:BColor,fontWeight: FontWeight.bold)),
                                            Text(snapShot.data[index].Deliver_Type,
                                                style: TextStyle(
                                                    fontSize: 15, color: Color(0xFF303030))),                                          ],
                                        ),
                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:<Widget>[
                                        Column(
                                          children: [
                                            Text("Reservation status :", style: TextStyle(fontSize: 13,color:BColor,fontWeight: FontWeight.bold)),
                                            Text(snapShot.data[index].Available?"Available":"Reserved",style: TextStyle(fontSize: 15)),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Expiry  Date :", style: TextStyle(fontSize: 13,color:BColor,fontWeight: FontWeight.bold)),
                                            Text(snapShot.data[index].Expiry_Date.substring(0,10),
                                                style: TextStyle(
                                                    fontSize: 10, color: Color(0xFF303030))),
                                          ],
                                        ),
                                      ],
                                    ),

                                    ListTile(
                                      leading: IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: BColor,
                                          size: 33,
                                        ),
                                        onPressed: () {
                                          id_donation=snapShot.data[index].id;
                                          Navigator.push(context,MaterialPageRoute(builder: (context){return Edit_donation(snapShot.data[index].id);}));
                                        },
                                      ),

                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 33,

                                        ),
                                        onPressed: () {
                                          delete_conf(snapShot.data[index].id);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        );
                      },
                      itemCount: snapShot.data.length,
                    );
                  }
                }
              },
            ),
          )
      ),
    );
  }
}

class donation{
  int id;
  int charity;
  String Name;
  String description;
  String Packing_Type;
  String Deliver_Type;
  String Expiry_Date;
  bool Available;
  donation(this.id,this.charity,this.Name,this.description,this.Packing_Type,this.Deliver_Type,this.Expiry_Date,this.Available);
}

