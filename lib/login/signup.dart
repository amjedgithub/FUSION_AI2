import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart'; 
import 'MyHomePage.dart';
import 'package:google_fonts/google_fonts.dart';
class SignupPage extends StatefulWidget {
  final Function? toggleView;
  SignupPage({this.toggleView});
  @override
  _SignupPageState createState() => _SignupPageState();
}
class _SignupPageState extends State<SignupPage> {
  bool _obscureText = true;
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // Get the FirebaseAuth instance
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController(); // Added a new controller for the confirm password field
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
        centerTitle: true,
      ),
     // Add a SingleChildScrollView to avoid overflow
     body: SingleChildScrollView( // Add a SingleChildScrollView to avoid overflow
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.only(top: 10.0), // Add padding to the top of the image
        child: ClipOval(
          // Wrap the image with a ClipOval widget to make it circular
          child: Image.asset('images/logo.png', width: 150, height: 150),
        ),
      ),
      Text('FOUSION AI',
          style: GoogleFonts.concertOne( // Use Google fonts for the text style
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 5, 5, 235))), // Change the color to blue
      // Added some sentences about the app
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Welcome to FOUSION AI, the app that lets you recognize text from images and documents. '
          'With FOUSION AI, you can scan, edit, and share text from any source. '
          'Sign up now and enjoy the power of FOUSION AI.',
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(), // Use Google fonts for the text style
        ),
      ),
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    autofocus: false,
                    validator: (value) {
                      if (value != null) {
                        if (value.contains('@') && value.endsWith('.com')) {
                          return null;
                        }
                        return 'Enter a Valid Email Address';
                      }
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                  SizedBox(height: 12.0),
                  TextFormField(
                      obscureText: _obscureText,
                      controller: _passwordController,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 8) {
                          return 'Password must be at least 8 characters in length';
                        }
                        // Return null if the entered password is valid
                        return null;
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ))),
                  SizedBox(height: 20.0),
                  // Added a new TextFormField for the confirm password field
                  TextFormField(
                    obscureText: _obscureText,
                    controller: _confirmPasswordController,
                    autofocus: false,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                      if (value.trim() != _passwordController.text.trim()) {
                        return 'Passwords do not match';
                      }
                      // Return null if the entered password is valid
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Confirm Password",
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Added a new TextButton for the sign up action
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Sign up the user using the email and password
                        User? user = (await _auth
                                .createUserWithEmailAndPassword(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim()))
                            .user; // Access the user property of the UserCredential object
                        if (user == null) {
                          // Show an error message if the sign up failed
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Sign up failed'),
                            ),
                          );
                        } else {
                          // Navigate to the home page if the sign up succeeded
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                        }
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                  ),
                  // Moved the TextButton for the switch to login below the sign up button
                  TextButton(
                    onPressed: () {
                      // Navigate to the login page when the user presses the switch to login button
                      Navigator.of(context).push(MaterialPageRoute( builder: (context) => MyHomePage(title: '',)));
                    },
                    child: Text('Go to Login'), // Added the child parameter
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}