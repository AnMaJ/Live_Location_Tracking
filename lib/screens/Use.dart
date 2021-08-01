import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Use extends StatefulWidget {
  const Use({Key? key}) : super(key: key);

  @override
  _UseState createState() => _UseState();
}

class _UseState extends State<Use> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("How to use",
            style: GoogleFonts.pacifico(fontSize: 30.0,color: Colors.white),),
          backgroundColor: Colors.brown[900],
          toolbarHeight: 70.0,
        ),
        backgroundColor: Colors.brown[200],
        body: SingleChildScrollView(
    child: Column(
            children:[



                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 500.0,
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
                            SizedBox(height: 20.0,),
                            Text('Welcome to Live Location Tracking App!', style: TextStyle(color: Colors.black54,fontSize: 20.0)),
                            Text(' '),
                                Text('This app allows you to from groups of your registered friends and shows you the location of members of a group on a map live!', style: TextStyle(color: Colors.black54,fontSize: 20.0)),
                                Text(' '),
                                Text('How to make a Group?', style: TextStyle(color: Colors.black54,fontSize: 20.0)),
                          Text(' '),
                               Text( 'To make a group of of registered users, go to the Make Groups tab and search the name of the member by its username.',
                                style: TextStyle(color: Colors.black54,fontSize: 20.0)),
                            Text(' '),
                            Text( 'If the user is registered on the app with the same username that you typed, it will be displayed in a list. Now, select the user and a chip will be created with the name of the user at the top. Similarly, add other users.',
                                style: TextStyle(color: Colors.black54,fontSize: 20.0)),
                            Text(' '),
                            Text('Once you have selected all the members, tap the Create Group button and give the name for your group in the pop up window and create your group.', style: TextStyle(color: Colors.black54,fontSize: 20.0)),
                            Text(' '),
                            Text('How to track a Group?', style: TextStyle(color: Colors.black54,fontSize: 20.0)),
                            Text(' '),
                            Text('You can only track the groups you are a part of. To track a group, go to My Groups tab and select the group that you want to track. Now, once you get to the maps page, you need to change dial at the bottom to adjust the radius around you in wich you want to see the members.', style: TextStyle(color: Colors.black54,fontSize: 20.0)),
                            Text(' '),
                            Text('Important: You will be able to access the location of other members only when they have opened your group at least once when they have logged in. So that their initial location is registered on the map.', style: TextStyle(color: Colors.black54,fontSize: 20.0)),
                            Text(' '),
                            Text('And we are done!', style: TextStyle(color: Colors.black54,fontSize: 20.0)),
                            Text(' '),
                            Text('Enjoy using the app!', style: TextStyle(color: Colors.black54,fontSize: 20.0)),
                            Text(' '),
                            SizedBox(height: 10.0,)
                          ],
                        ),
                      ),
                      onPressed: (){
                      },),
                  ),
                ),

            ]
        ))

    );
  }
}
