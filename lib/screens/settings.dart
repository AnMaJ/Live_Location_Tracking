import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_screen.dart';



class settings extends StatefulWidget {
   settings({Key? key,required this.email,required this.password,required this.name}) : super(key: key);
 String? email='';
   String? name='';
   String? password='';
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
String currentPassword='';
String newPassword='';
String? email='';
String? name='';

CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> updateName() {
  // Call the user's CollectionReference to add a new user
  return users
      .doc(widget.email)
      .update({'name': widget.name})
      .then((value) => print("Username Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}




  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
        appBar: AppBar(
          title: Center(child: Row(
            children: [SizedBox(width: 80,),
              Text('Login',style: GoogleFonts.pacifico(fontSize: 30.0)),

            ],
          )),
          backgroundColor: Colors.brown[900],
          toolbarHeight: 70.0,
        ),
        backgroundColor: Colors.brown[200],
        body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [

                  Container(
                    width:370,
                    child: TextFormField(
                      onChanged: (val){
                        currentPassword = val;
                      },
                      initialValue: "${widget.password}",
                      cursorColor: Colors.brown,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.brown[800],fontWeight: FontWeight.bold,fontSize: 20.0),
                        contentPadding: EdgeInsets.fromLTRB(10, 50, 10, 0),

                        fillColor: Colors.brown,
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.brown, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width:370,
                    child: TextFormField(
                      onChanged: (val){
                        newPassword = val;
                      },
                      initialValue: "${widget.password}",
                      cursorColor: Colors.brown,
                      decoration: InputDecoration(
                        labelText: "New Password",
                        labelStyle: TextStyle(color: Colors.brown[800],fontWeight: FontWeight.bold,fontSize: 20.0),
                        contentPadding: EdgeInsets.fromLTRB(10, 50, 10, 0),

                        fillColor: Colors.brown,
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.brown, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width:370,
                    child: TextFormField(
                      onChanged: (val){
                        name = val;
                      },
                      initialValue: "${widget.name}",
                      cursorColor: Colors.brown,
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(color: Colors.brown[800],fontWeight: FontWeight.bold,fontSize: 20.0),
                        contentPadding: EdgeInsets.fromLTRB(10, 50, 10, 0),

                        fillColor: Colors.brown,
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.brown, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 70.0,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async{

                        updateName();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen( )));

                      },
                      style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                        primary: Colors.brown[900],
                        elevation: 10.0,
                      ),
                      child: Text(
                        'Update Changes',
                        style: GoogleFonts.pacifico(fontSize: 25.0),

                      ),

                    ),
                  ),

                ],
              ),
            )
        )
    );
  }
}
