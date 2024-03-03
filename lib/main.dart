import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './login/login.dart'; // Use the ./ notation
import 'login/signup.dart'; // Use the ./ notation
import 'login/MyHomePage.dart'; // Use the ./ notation
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp()); // Remove the const keyword
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key); // Remove the const keyword

  static const title = 'FUSION AI';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        // Use a FutureBuilder widget
        future: Firebase.initializeApp(), // Wait for the Firebase app initialization
        builder: (context, snapshot) {
          // Check the snapshot data
          if (snapshot.hasError) {
            // If there is an error, return an error widget
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            // If the connection is done, return a StreamBuilder widget
            return StreamBuilder(
              stream: FirebaseAuth.instance
                  .authStateChanges(), // Listen to the authentication state changes
              builder: (context, snapshot) {
                // Check the snapshot data
                if (snapshot.hasError) {
                  // If there is an error, return an error widget
                  return Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.active) {
                  // If the connection is active, check the user data
                  User? user = snapshot.data as User?;
                  if (user == null) {
                    // If the user is null, return the login page
                    return const LoginPage();
                  } else {
                    // If the user is not null, return the home page
                    return MyHomePage(title: '',);
                  }
                }
                // Otherwise, return a loading widget
                return Center(child: CircularProgressIndicator());
              },
            );
          }
          // Otherwise, return a loading widget
          return Center(child: CircularProgressIndicator());
        },
      ),
      routes: {
        "signup": (context) => SignupPage(),
        "login": (context) => const LoginPage(),
        "home": (context) => MyHomePage(title: '',),
      },
    );
  }
}
