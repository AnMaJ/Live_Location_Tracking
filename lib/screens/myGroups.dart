import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_location_app/models/MainPage.dart';
import 'package:live_location_app/screens/Locationpage.dart';


class myGroups extends StatefulWidget {
  const myGroups({Key? key, required this.name,required this.email}) : super(key: key);
final name;
final email;
  @override
  _myGroupsState createState() => _myGroupsState();
}

class _myGroupsState extends State<myGroups> {

String grpid='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        title: Text('My Groups',style: GoogleFonts.pacifico(fontSize: 30.0)),
        backgroundColor: Colors.brown[900],
        toolbarHeight: 70.0,
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection('groups').where('users', arrayContains:widget.name).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var groupdata = snapshot.data!.docs;
                  return SizedBox(
                    height: 613.7,
                    child: ListView.builder(
                    itemCount:snapshot.data!.docs.length ,


                    itemBuilder: (context,index) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
                          child: Card(
                           child: ListTile(
                                          onTap: ()async{
                                            grpid= snapshot.data!.docs[index].id;
                                            CollectionReference users = FirebaseFirestore.instance.collection('users');
                                            DocumentSnapshot ds= await users.doc(widget.email).get();
                                            getLoc();
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Locationpage(grpuid: grpid,name: ds.get('name'),email: widget.email,locdata:_currentPosition,grpname: groupdata[index]['groupname'])));

                                          },
                             tileColor: Colors.brown[50],


                          title: Text("Group Name: " + groupdata[index]['groupname'],
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold
                          )),
                             subtitle: Text("Members: " + groupdata[index]['users'].join(',')),
                            )
                        ),
                        )
                      );
                    }
                  )
                  );

                }

          ),
          Divider(),
          Center(
            child: Container(
              width: 350.0,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                },
                style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                  primary: Colors.brown[900],
                  elevation: 10.0,
                ),
                child: Row(
                  children: [
                    SizedBox(width: 40.0),
                    Icon(Icons.add),
                    Text(
                      'Add a new group',
                      style: GoogleFonts.pacifico(fontSize: 30.0)
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),

    );
  }
late LocationData _currentPosition;
getLoc() async {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  Location location = Location();


  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  _currentPosition = await location.getLocation();

  location.onLocationChanged.listen((LocationData currentLocation) {
    print("location at the groups page is ${currentLocation.latitude} : ${currentLocation.longitude}");
    setState(() {
      _currentPosition = currentLocation;
    });
  });
}

}
