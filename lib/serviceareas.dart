import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class ServiceAreas extends StatefulWidget {
  @override
  _ServiceAreasState createState() => _ServiceAreasState();
}

class _ServiceAreasState extends State<ServiceAreas> {
  @override
  Widget build(BuildContext context) {
    Widget image_slider_carousel = Container(
      height: 200,
      width: double.infinity,
      child: Carousel(
        boxFit: BoxFit.fill,
        images: [
          AssetImage("images/shahunagar.jpg"),
          AssetImage("images/pramodnagar.jpg"),
          AssetImage("images/indiragarden.jpg"),
          AssetImage("images/tirupatiapt.jpg"),
          AssetImage("images/kshirecolony.jpg"),
          AssetImage("images/tulsiramnagar.jpg"),
        ],
        autoplay: true,
        indicatorBgPadding: 1.0,
        dotColor: Colors.black,
        dotSize: 4.0,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        centerTitle: true,
        title: Text("Service Area's", style: TextStyle(color: Colors.black54)),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    height: 600,
                    width: double.infinity,
                    color: Colors.white,
                    child: ListView(
                      children: <Widget>[
                        image_slider_carousel,
                        Divider(
                          height: 20,
                          color: Colors.black,
                          indent: 40,
                          endIndent: 40,
                        ),
                        Container(
                          color: Colors.white,
                          padding: new EdgeInsets.all(10.0),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "These Service is only for Dhule City in Following Areas",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 20,
                          color: Colors.white,
                          indent: 40,
                          endIndent: 40,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "  1. Shahu Nagar",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "  2. Pramod Nagar",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "  3. Indira Garden",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "  4. Tirupati Apartment Area",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "  5. Kshire Colony",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "  6. Tulshiram Nagar",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
