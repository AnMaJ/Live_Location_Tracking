import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_location_app/screens/Home.dart';
import 'package:live_location_app/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String email = '';
  String password = '';
  String? name=' ';

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
            height:300.0,
              width: 400.0,
              child: Image.network('https://i.imgur.com/Fnqrjms.png')),

          Container(
            width:370,
            child: TextFormField(
              onChanged: (val){
                email = val;
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
            height: 70.0,
            width: 200,
            child: ElevatedButton(
              onPressed: () async{
                try {
                  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password
                  );
                  CollectionReference users = FirebaseFirestore.instance.collection('users');
                  DocumentSnapshot ds= await users.doc(email).get();


                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home(name: ds.get('name'),email: email)));
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
              },
              style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
                primary: Colors.brown[900],
                elevation: 10.0,
              ),
              child: Text(
                'Login',
                style: GoogleFonts.pacifico(fontSize: 25.0),

              ),

            ),
          ),
          SizedBox(height: 20.0),
          Divider(thickness: 2.0),
          SizedBox(height: 20.0),
          Center(
            child: Row(
              children: [
                SizedBox(width: 110.0),
                Text("Don't have an account?",
                style: TextStyle(fontSize: 15.0),),
                GestureDetector(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage( )));

                },
                  child: Text('Sign Up',
                style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15.0)))
              ],
            ),
          )
        ],
      ),
    )
      )
         );
  }
}
