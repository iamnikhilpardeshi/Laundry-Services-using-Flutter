import 'package:client/orderlist.dart';
import 'package:client/ratecard.dart';
import 'package:client/serviceareas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'authscreen.dart';
import 'package:share/share.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  final String email;
  final String imageUrl;
  HomeScreen(
      {Key key,
      @required this.username,
      @required this.email,
      @required this.imageUrl})
      : super(key: key);

  final mobilenoController = TextEditingController();
  final cityController = TextEditingController();
  final flatController = TextEditingController();
  final areaController = TextEditingController();
  final landmarkController = TextEditingController();

  String mobileno, city, flat, area, landmark;

  final _formkey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var currentTime;
  var currentdatetime;
  var useremail = "";
  var name = "";

  String value;

  final databaseReference = Firestore.instance;

  int group = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title:
              Text("Hi " + username, style: TextStyle(color: Colors.black54)),
          leading: IconButton(
            color: Colors.black54,
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          backgroundColor: Colors.blue[50],
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 32,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Exit"),
                      content: Text("Do you want to logout.."),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No")),
                        FlatButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              await googleSignIn.disconnect();
                              await googleSignIn.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => AuthScreen()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Text("Yes")),
                      ],
                    ),
                  );
                },
                color: Colors.black54),
          ],
        ),

//navigationdrawer
        drawer: new Drawer(
            child: new ListView(children: <Widget>[
          Container(
            color: Colors.blue[50],
            child: new UserAccountsDrawerHeader(
              accountName: new Text(username,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              accountEmail: new Text(email,
                  style: TextStyle(fontSize: 15, color: Colors.black54)),
              decoration: new BoxDecoration(
                color: Colors.blue[50],
              ),
              currentAccountPicture:
                  CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
            ),
          ),
          Card(
            child: new ListTile(
                leading: Icon(Icons.location_on),
                title: new Text("Service area's"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceAreas(),
                      ));
                }),
          ),
          Card(
            child: new ListTile(
                leading: Icon(Icons.info),
                title: new Text("About us"),
                onTap: () {
                  Navigator.pop(context);
                }),
          ),
          Card(
            child: new ListTile(
                leading: Icon(Icons.share),
                title: new Text("Share"),
                onTap: () {
                  // Navigator.pop(context);
                  Share.share(
                    'check out my website https://google.com/',
                    subject: 'Sharing on Email');
                }),
          ),
        ])),

//bottom nevigationbar coding
        bottomNavigationBar: Container(
          height: 75,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -7),
                blurRadius: 33,
                color: Color(0xFF6DAED9).withOpacity(0.11),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.account_balance_wallet),
                color: Colors.black54,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RateCard(),
                      ));
                },
              ),
              IconButton(
                icon: Icon(Icons.home),
                color: Colors.black54,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                color: Colors.black54,
                onPressed: () {
                  value = email;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderList(value: value)));
                },
              ),
            ],
          ),
        ),

        //floating action button coding
        floatingActionButton: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.transparent,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                currentdatetime = DateTime.now();
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0))),
                    backgroundColor: Colors.white,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Choose your Location",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20,
                                color: Colors.black,
                                indent: 40,
                                endIndent: 40,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Column(
                                  children: <Widget>[
                                    Form(
                                        key: _formkey,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            TextFormField(
                                              keyboardType: TextInputType.phone,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                focusColor: Colors.blue[50],
                                                prefixIcon: Icon(Icons.phone),
                                                labelText: "Mobile No:",
                                                labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                hintText: "Mobile No:",
                                                contentPadding:
                                                    EdgeInsets.all(12),
                                              ),
                                              autofocus: true,
                                              controller: mobilenoController,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "Please Enter Mobile No.";
                                                }
                                                if (value.length < 10) {
                                                  return 'Please type Correct Mobile no.';
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                focusColor: Colors.blue[50],
                                                prefixIcon: Icon(Icons.home),
                                                labelText:
                                                    "Flat, House no, Building, Apartment:",
                                                labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                hintText:
                                                    "Flat, House no, Building, Apartment:",
                                                contentPadding:
                                                    EdgeInsets.all(12),
                                              ),
                                              autofocus: true,
                                              controller: flatController,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "Please Enter Flat no.";
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusColor: Colors.blue[50],
                                                prefixIcon: Icon(Icons.home),
                                                labelText:
                                                    "Area, Colony, Street, Sector, Village:",
                                                labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                hintText:
                                                    "Area, Colony, Street, Sector, Village:",
                                                contentPadding:
                                                    EdgeInsets.all(12),
                                              ),
                                              autofocus: true,
                                              controller: areaController,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "Please Enter Area..";
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                focusColor: Colors.blue[50],
                                                prefixIcon: Icon(Icons.home),
                                                labelText: "Landmark:",
                                                labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                hintText:
                                                    "Landmark e.g. near _______ :",
                                                contentPadding:
                                                    EdgeInsets.all(12),
                                              ),
                                              autofocus: true,
                                              controller: landmarkController,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "Please Enter Landmark..";
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                focusColor: Colors.blue[50],
                                                prefixIcon: Icon(Icons.home),
                                                labelText: "City:",
                                                labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                hintText: "City:",
                                                contentPadding:
                                                    EdgeInsets.all(12),
                                              ),
                                              autofocus: true,
                                              controller: cityController,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "Please Enter City..";
                                                }
                                              },
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 40,
                                      child: RaisedButton(
                                        onPressed: () {
                                          if (_formkey.currentState
                                              .validate()) {
                                            //save record
                                            createRecord();
                                            //create profile
                                            createProfile();
                                            //dialog box
                                            showDialog(
                                              context: context,
                                              builder: (context) => CustomDialog(
                                                  title: "Success",
                                                  description:
                                                      "Your Booking has been Successful."),
                                            );
                                          } else {}
                                        },
                                        splashColor: Colors.yellow[200],
                                        animationDuration: Duration(seconds: 2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.black),
                                        ),
                                        child: Text("Continue"),
                                        color: Colors.blue[100],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ));
                //bottomsheet coding
              },
              child: Icon(Icons.add_shopping_cart, color: Colors.black54),
              backgroundColor: Colors.blue[50],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 140.0,
                color: Colors.black,
                child: Center(
                  child: Image.asset("images/ironclothhome.jpg",
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                width: double.infinity,
                height: 140.0,
                color: Colors.white,
                child: Center(
                  child:
                      Image.asset("images/howitworks.jpg", fit: BoxFit.cover),
                ),
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                child: Row(children: <Widget>[
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    height: 90,
                    width: 180,
                    // color: Colors.black,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        ),
                        // color: Color(0xff7c94b6),
                        color: Colors.black45,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("images/container.jpg"),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.2), BlendMode.dstATop),
                        )),
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: Image.asset("images/ironiconpng.png")),
                          Expanded(
                              child: Text("Ironing Service",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)))
                        ]),
                  )),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: const EdgeInsets.all(10.0),
                          height: 90,
                          width: 180,
                          // color: Colors.black,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                              ),
                              color: Colors.black45,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/container.jpg"),
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.dstATop),
                              )),
                          alignment: Alignment.center,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: Image.asset("images/washiron.png")),
                                Expanded(
                                    child: Text("Wash & Iron",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)))
                              ])))
                ]),
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                padding: EdgeInsets.only(
                    top: 0, bottom: 10.0, left: 10.0, right: 10.0),
                child: Row(children: <Widget>[
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: const EdgeInsets.all(10.0),
                          height: 90,
                          width: 180,
                          // color: Colors.black,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                              ),
                              // color: Color(0xff7c94b6),
                              color: Colors.black45,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/container.jpg"),
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.dstATop),
                              )),
                          alignment: Alignment.center,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child:
                                        Image.asset("images/drycleanicon.png")),
                                Expanded(
                                    child: Text("Dry Cleaning",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)))
                              ]))),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: const EdgeInsets.all(10.0),
                          height: 90,
                          width: 180,
                          // color: Colors.black,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                              ),
                              // color: Color(0xff7c94b6),
                              color: Colors.black45,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/container.jpg"),
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.dstATop),
                              )),
                          alignment: Alignment.center,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: Image.asset("images/starch.png")),
                                Expanded(
                                    child: Text("Starch Service",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)))
                              ])))
                ]),
              ),
            ],
          ),
        ));
  }

//create profile
  void createProfile() async {
    await databaseReference.collection("profile").document(email).setData({
      'email': email,
      'name': username,
      'mobileno': mobilenoController.text,
      'address': flatController.text +
          ", " +
          areaController.text +
          ", " +
          landmarkController.text +
          ", " +
          cityController.text,
      'orderstatus': "Pending",
      'orderrequest': currentdatetime.toString(),
      'orderpickup': "-",
      'ordercomplete': "-",
      'orderbill': "-",
      'garmentdescription': "-"
    });
  }

  //created data
  void createRecord() async {
    await databaseReference
        .collection("requestorder")
        // .document(mobilenoController.text)
        .document() //cityController.text
        .setData({
      'mobileno': mobilenoController.text,
      'name': username,
      'address': flatController.text +
          ", " +
          areaController.text +
          ", " +
          landmarkController.text +
          ", " +
          cityController.text,
      'email': email,
      'requestdate': currentdatetime.toString(),
    });
  }
}

//custom dialogbox coding
class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;

  CustomDialog({this.title, this.description, this.buttonText, this.image});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 100,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 16.0),
              Text(description,
                  style: TextStyle(
                    fontSize: 14.0,
                  )),
              SizedBox(
                height: 24.0,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text("Press Here.."),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: Center(
            child: Expanded(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                backgroundImage: AssetImage("images/pickupboy.gif"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
