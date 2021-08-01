import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_location_app/models/MainPage.dart';
import 'package:live_location_app/screens/myGroups.dart';
import 'package:live_location_app/screens/settings.dart';
import 'package:live_location_app/screens/welcome_screen.dart';

import 'Use.dart';

User? loggedInUser;
class Home extends StatefulWidget {

  const Home( {Key? key,required this.name, required this.email}) : super(key: key);

  final String? name;
  final String? email;

  @override

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
var locationMessage=' ';
void getCurrentLocation() async{
  var position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  var lastPosition= await Geolocator.getLastKnownPosition();
  print(lastPosition);
  setState((){
    locationMessage="$position";
  });
}
CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> addLocation() {
  // Call the user's CollectionReference to add a new user
  return users
      .doc(widget.email)
      .update({'Location': locationMessage})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text("Welcome ${widget.name}!",
          style: GoogleFonts.pacifico(fontSize: 30.0,color: Colors.white),),
        ),
        backgroundColor: Colors.brown[900],
        toolbarHeight: 70.0,
      ),
        backgroundColor: Colors.brown[200],
      body: Column(
          children:[

Row(children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 190.0,
                child: ElevatedButton(


                  style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.brown, width: 2),
                  ),
                    primary: Colors.brown[100],
                    elevation: 10.0,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Image.network('https://static.thenounproject.com/png/79377-200.png'),
                        Text('Make Groups',
                            style: TextStyle(color: Colors.black54,fontSize: 20.0)),
                        SizedBox(height: 10.0,)
                      ],
                    ),
                  ),
                  onPressed: (){
                    getCurrentLocation();
                    addLocation();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                  },),
              ),
            ),
  Padding(
    padding: const EdgeInsets.all(8.0-0.571),
    child: Container(
      width: 190.0,
      child: ElevatedButton(


        style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.brown, width: 2),
        ),
          primary: Colors.brown[100],
          elevation: 10.0,
        ),
        child: Center(
          child: Column(
            children: [
              Image.network('https://i.imgur.com/Fnqrjms.png'),
              Text('My Groups',
                  style: TextStyle(color: Colors.black54,fontSize: 20.0)),
              SizedBox(height: 10.0,)
            ],
          ),
        ),
        onPressed: ()async{
          getCurrentLocation();
          addLocation();
          FirebaseFirestore.instance.collection('users');
          DocumentSnapshot ds= await users.doc(widget.email).get();
          Navigator.push(context, MaterialPageRoute(builder: (context) => myGroups(name: ds.get('name'),email:widget.email)));
        }
        ,),
    ),
  ),


]),
            Row(children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 190.0,
                  child: ElevatedButton(


                    style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.brown, width: 2),
                    ),
                      primary: Colors.brown[100],
                      elevation: 10.0,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Image.network('https://static.thenounproject.com/png/3037130-200.png'),
                          Text('How to use?',
                              style: TextStyle(color: Colors.black54,fontSize: 20.0)),
                          SizedBox(height: 10.0,)
                        ],
                      ),
                    ),
                    onPressed: (){
                      getCurrentLocation();
                      addLocation();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Use()));
                    },),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0-0.571),
                child: Container(
                  width: 190.0,
                  child: ElevatedButton(


                    style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.brown, width: 2),
                    ),
                      primary: Colors.brown[100],
                      elevation: 10.0,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Image.network('https://www.iconpacks.net/icons/2/free-settings-icon-3110-thumb.png'),
                          Text('Settings',
                              style: TextStyle(color: Colors.black54,fontSize: 20.0)),
                          SizedBox(height: 10.0,)
                        ],
                      ),
                    ),
                    onPressed: ()async{
                      getCurrentLocation();
                      addLocation();
                      FirebaseFirestore.instance.collection('users');
                      DocumentSnapshot ds= await users.doc(widget.email).get();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => settings(email:widget.email as String,password: ds.get('password'),name: widget.name)));
                    }
                    ,),
                ),
              ),


            ]),
            Padding(
              padding: const EdgeInsets.all(8.0-0.571),
              child: Container(
                width: 190.0,
                child: ElevatedButton(


                  style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.brown, width: 2),
                  ),
                    primary: Colors.brown[100],
                    elevation: 10.0,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Image.network('https://www.iconpacks.net/icons/2/free-exit-logout-icon-2857-thumb.png'),
                        Text('Logout',
                            style: TextStyle(color: Colors.black54,fontSize: 20.0)),
                        SizedBox(height: 10.0,)
                      ],
                    ),
                  ),
                  onPressed: ()async{
                    getCurrentLocation();
                    addLocation();
                    FirebaseFirestore.instance.collection('users');
                    DocumentSnapshot ds= await users.doc(widget.email).get();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
                  }
                  ,),
              ),
            ),




          ]
        )

    );
  }
}

