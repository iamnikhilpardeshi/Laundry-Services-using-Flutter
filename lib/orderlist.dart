import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderList extends StatefulWidget {
  String value;
  OrderList({this.value});

  @override
  _OrderListState createState() => _OrderListState(value);
}

class _OrderListState extends State<OrderList> {
  String value;
  _OrderListState(this.value);

  Stream orderlist;
  final copydataReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[50],
          centerTitle: true,
          title: Text("My Cart", style: TextStyle(color: Colors.black54)),
        ),
        body: Column(
          children: <Widget>[
            Container(
                height: 140, width: double.infinity, child: _profilelistview()),
            Container(
                height: 170, width: double.infinity, child: _orderdetailview()),
            Expanded(
              child: Container(
                child: OrderListPage(value: value),
              ),
            ),
          ],
        ));
  }

  Widget _profilelistview() {
    return new StreamBuilder(
        stream: Firestore.instance
            .collection('profile')
            .document(value)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("loading");
          }
          var userDocument = snapshot.data;
          return Card(
            child: new ListTile(
                title: Text("Name: " + userDocument["name"]),
                subtitle: Text("Mobile No: " +
                    userDocument["mobileno"] +
                    "\n"
                        "Address: " +
                    userDocument["address"] +
                    "\n"
                        "Email: " +
                    userDocument["email"])),
          );
        });
  }

  Widget _orderdetailview() {
    return new StreamBuilder(
        stream: Firestore.instance
            .collection('profile')
            .document(value)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("loading");
          }
          var userDocument = snapshot.data;
          return Card(
            child: new ListTile(
              title: Text("Status: " + userDocument["orderstatus"]),
              subtitle: Text("Request Date: " +
                      userDocument["orderrequest"] +
                      "\n"
                          "Pickup Date: " +
                      userDocument["orderpickup"] +
                      "\n"
                          "Received Date: " +
                      userDocument["ordercomplete"] +
                      "\n"
                          "Bill: " +
                      userDocument["orderbill"]
                  // +"\n"+
                  // "Garment Description: "+userDocument["garmentdescription"]
                  ),
            ),
          );
        });
  }
}

class OrderListPage extends StatefulWidget {
  String value;
  OrderListPage({this.value});
  @override
  _OrderListPageState createState() => _OrderListPageState(value);
}

class _OrderListPageState extends State<OrderListPage> {
  String value;
  _OrderListPageState(this.value);

  Stream orderlist;

  final copydataReference = Firestore.instance;

//getdata
  getData() async {
    return await Firestore.instance
        .collection("profile")
        .document(value)
        .collection("mycart")
        .snapshots(); //stream
  }

  @override
  void initState() {
    getData().then((results) {
      setState(() {
        orderlist = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _orderlistview(),
    );
  }

  Widget _orderlistview() {
    if (orderlist != null) {
      return StreamBuilder(
          stream: orderlist,
          builder: (context, snapshot) {
            if (snapshot.data == null)
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: EdgeInsets.all(5.0),
                itemBuilder: (context, i) {
                  return Card(
                    child: new ListTile(
                      title: Text("Bill: Rs." +
                          snapshot.data.documents[i].data['orderbill']),
                      subtitle: Text("Pick up Date: " +
                              snapshot.data.documents[i].data['orderpickup'] +
                              "\n"
                                  "Received Date: " +
                              snapshot.data.documents[i].data['ordercomplete'] +
                              "\n"
                          // "Garment Description: "+snapshot.data.documents[i].data['garmentdescription']
                          ),
                      onTap: () {},
                    ),
                  );
                });
          });
    } else {
      return Text("Loading, please wait..");
    }
  }
}
