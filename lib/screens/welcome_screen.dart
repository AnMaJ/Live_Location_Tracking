import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_location_app/screens/login_screen.dart';
import 'package:live_location_app/screens/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);


  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Center(
        child: Column(
        children: [
          SizedBox(height: 95.0),
          Text('LIVE LOCATION APP',
            style: GoogleFonts.josefinSans(fontSize: 40.0),),
          SizedBox(height: 20.0),
            Image.network('https://img.etimg.com/thumb/msid-61131171,width-640,resizemode-4,imgsize-30471/easy-to-use.jpg'),
Text('Welcome!',
style: GoogleFonts.pacifico(fontSize: 30.0),),

          Text('Track the live location of you and your group!',style: GoogleFonts.pacifico(fontSize: 20.0),),
          SizedBox(height: 50.0),
          Container(width: 200.0,
            height: 50.0,
          child: ElevatedButton(

            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
            },

            style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
              primary: Colors.grey[850],
              elevation: 10.0,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,5.0),
              child: Text(
                'Sign Up',
                style: GoogleFonts.pacifico(fontSize: 25.0),
              ),
            ),
          ),),
          SizedBox(height: 20.0),
          Container(
            width: 200.0,
            height: 50.0,
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
                primary: Colors.grey[800],
                elevation: 10.0,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,5.0),
                child: Text(
                  'Login',
                  style: GoogleFonts.pacifico(fontSize: 25.0),
                ),
              ),
            ),
          ),
          SizedBox(height:30.0),
          Divider(thickness:1.0),
          SizedBox(height:10.0),
          Text('Created by Mansi',style: GoogleFonts.josefinSans(fontSize: 20.0,color: Colors.grey),),
        ],
      ),
    ));
  }
}
