import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'splashscreen.dart';
import 'authscreen.dart';
import 'package:flutter/services.dart';

// Defining routes for navigation
var routes = <String, WidgetBuilder>{
  "/auth": (BuildContext context) => AuthScreen(),
  "/home": (BuildContext context) => HomeScreen(
        username: name,
        email: email,
        imageUrl:imageUrl
      ),
};
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Client',
    routes: routes,
    home: SplashScreen(),
  ));
}
