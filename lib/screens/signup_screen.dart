import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_location_app/screens/Home.dart';

import 'login_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  String email = '';
  String password = '';
  String name= '';
  String location= '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Center(child: Row(
          children: [SizedBox(width: 80,),
            Text('Sign Up',style: GoogleFonts.pacifico(fontSize: 30.0)),

          ],
        )),
        backgroundColor: Colors.brown[900],
        toolbarHeight: 70.0,
      ),
      backgroundColor: Colors.brown[200],
      body:SingleChildScrollView(
    child: Center(
        child: Column(
          children: [

               Image.network('https://static.thenounproject.com/png/1120654-200.png'),

            Container(
              width:370,
              child: TextFormField(
                onChanged: (val){
                  email = val;
                  print(email);
                },
                cursorColor: Colors.brown,
                decoration: InputDecoration(
                  labelText: "Email ID",
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
                  password = val;
                  print(password);
                },
                obscureText: true,
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
                  name = val;
                  print(name);
                },
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
            SizedBox(height: 40.0),
            Container(
              height: 70.0,
              width: 200,
              child: ElevatedButton(
                onPressed: () async{
                  try {

                    final uid = FirebaseAuth.instance.currentUser!.uid;

                    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email,
                        password: password
                    );
                    await FirebaseFirestore.instance.collection('users')
                      .doc(email)
                      .set({
                        'name' : name,
                        'email': email,
                        'uid' : uid,
                        'Location': location,
                      'password': password,
                      })

                      .then((value) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Home( name: name, email: email)));
                      })
                      .catchError((err) {
                        print(err);
                      });

                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                  primary: Colors.brown[900],
                  elevation: 10.0,
                ),
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.pacifico(fontSize: 25.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Divider(thickness: 2.0),
            SizedBox(height: 10.0),
            Center(
              child: Row(
                children: [
                  SizedBox(width: 110.0),
                  Text("Already have an account?",
                    style: TextStyle(fontSize: 15.0),),
                  GestureDetector(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen( )));

                  },
                      child: Text('Login',
                          style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15.0)))
                ],
              ),
            )
          ],
        ),
      ),
    )
    );
  }
}
