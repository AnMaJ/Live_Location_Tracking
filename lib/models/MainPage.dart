import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage();
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
  new GlobalKey<ScaffoldState>();

  late TextEditingController _searchQuery;
  bool _isSearching = false;
  String searchQuery = "Search query";

  @override
  void initState() {
    super.initState();
    _searchQuery = new TextEditingController();
  }

  void _startSearch() {
    print("open search box");
    ModalRoute
        .of(context)!
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    print("close search box");
    setState(() {
      _searchQuery.clear();
      updateSearchQuery("Search query");
    });
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
    Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return new InkWell(
      onTap: () => scaffoldKey.currentState!.openDrawer(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
             Text('Search members',
              style: GoogleFonts.pacifico(fontSize: 30.0,color: Colors.white),),
          ],
        ),
      ),
    );
  }
 String _username=' ';

  List<String> _usernames=<String>[];
  List<String> _selectedusernames=<String>[];
  Map<String,bool> _selectedusernamesbool =<String, bool>{};
  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      cursorColor: Colors.black,
      decoration: const InputDecoration(
        hintText: 'Search by username',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (text){
        print(text);
        int i=0;
        _usernames.clear();
        FirebaseFirestore.instance.collection('users').where('name', isEqualTo : text)
        .get()
        .then((snapshot){
          setState(() {
            snapshot.docs.forEach((element){

                if(!_usernames.contains(element['name'])){
                  _usernames.insert(i,element['name']);
                  print(_usernames[0]);
                  if(_selectedusernames.contains(element['name'])){
                    _selectedusernamesbool.update(
                      element['name'],(value)=>false,
                      ifAbsent:()=>false,

                    );
                      }else{
                    _selectedusernamesbool.update(
                      element['name'],(value)=>true,
                      ifAbsent: ()=>true,

                    );
                  }
                  print(_selectedusernamesbool);
                  i++;
                }

              }
            );
           }
          );
        }
        );
      },
    );
  }

  void updateSearchQuery(String newQuery) {

    setState(() {
      searchQuery = newQuery;
    });
    print("search query " + newQuery);

  }
  final _formKey = GlobalKey<FormState>();
  List<Widget> _buildActions() {

    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  Widget _buildChip(String label, Color color){
    bool _isDeleted=false;
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.black,
        child: Text(label.toUpperCase(),textAlign: TextAlign.center,)
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        )
      ),

       deleteIcon:Icon(Icons.close_rounded),
      onDeleted: () {
        setState(() {
         _deleteselected(label);
        });
      },

      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      key: scaffoldKey,
      appBar: new AppBar(
        leading: _isSearching ? const BackButton() : null,
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
        backgroundColor: Colors.brown[900],
        toolbarHeight: 70.0,
      ),
      backgroundColor: Colors.brown[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:const EdgeInsets.symmetric(), child:Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          spacing: 6.0,
          runSpacing: 6.0,

          children: _selectedusernames.map((item)=>_buildChip(item,Color(0xFFff8666)))
            .toList()
            .cast<Widget>())
        )
      ),

             Divider(thickness: 1.0),
           SizedBox(height: 100.0,
             child: ListView.builder(itemCount: _usernames.length,

                shrinkWrap: true,
                itemBuilder: (BuildContext context,int index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      selectedTileColor: Colors.grey[300],
                     hoverColor: Colors.grey[300],
                     leading: Icon(Icons.person),
                        tileColor: Colors.white,
                        trailing: GestureDetector(onTap: (){},
                        child: Icon(Icons.check)),
                        title:Text("${_usernames[index]}"),
                      onTap: (){setState(() {
                        _selectedusernames.insert(_selectedusernames.length,_usernames[index]);
                        print(_selectedusernames.length);

                      });


                      },

                    ),
                  );
                })
           ),
            ElevatedButton(onPressed: (){
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.brown[100],
        content: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  child: Icon(Icons.close,color: Colors.white,),
                  backgroundColor: Colors.brown,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (val){
                        grpname = val;
                      },
                      cursorColor: Colors.brown,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Group Name',
                        labelStyle: TextStyle(color: Colors.brown[800],fontWeight: FontWeight.bold,fontSize: 20.0),
                        fillColor: Colors.brown
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text("Create Group"),
                      onPressed: () {

                        creategroupcollection();
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

            );
    },
              style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
                primary: Colors.brown[900],
                elevation: 10.0,
              ),
    child: Text('Create Group'),

    )
          ],
        ),
      ),
    );
  }
  void _deleteselected(String label) {
    setState(
          () {
        _selectedusernames.removeAt(_selectedusernames.indexOf(label));
      },
    );
  }
  String grpname=' ';
  Future<void> creategroupcollection() async{
    _selectedusernames.insert(_selectedusernames.length,_username);
    Map<String,dynamic> mapgroups={
      'groupname': grpname,
      'users':_selectedusernames
    };
    try{
      await FirebaseFirestore.instance.collection('groups').add(mapgroups);

      ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text('Group Created!'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.fromLTRB(35.0, 0, 35.0, 10.0),
        backgroundColor: Colors.brown,));
      print('group created');
      setState(() {
        _selectedusernames.clear();
        _selectedusernamesbool.clear();
      });
    }catch(e){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to create a group'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.fromLTRB(35.0, 0, 35.0, 10.0),
        backgroundColor: Colors.redAccent,)
      );
    }
  }
}



