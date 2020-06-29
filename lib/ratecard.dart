import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RateCard extends StatefulWidget {
  @override
  _RateCardState createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[50],
          centerTitle: true,
          title: Text("Rate Card", style: TextStyle(color: Colors.black54)),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return potrait();
          } else {
            return landscape();
          }
        }));
  }

  Widget potrait() {
    return ListPage();
  }

  Widget landscape() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "Sorry! landscape mode is not available. Do your phone Potrait."),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Stream orderlist;

  final copydataReference = Firestore.instance;

//getdata
  getData() async {
    return await Firestore.instance.collection("rates").snapshots(); //stream
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

// update data
  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection("rates")
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

//deleting data
  deletedData(docId) {
    Firestore.instance
        .collection("rates")
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ratelistview(),
    );
  }

  Widget _ratelistview() {
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
                      title: Text(snapshot.data.documents[i].data['title']),
                      subtitle: Text("Ironing Price: " +
                          snapshot.data.documents[i].data['iron'] +
                          "\n"
                              "Washing Price: " +
                          snapshot.data.documents[i].data['wash'] +
                          "\n"
                              "Dry Cleaning Price: " +
                          snapshot.data.documents[i].data['dryclean'] +
                          "\n"
                              "Starch Price: " +
                          snapshot.data.documents[i].data['starch']),
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
