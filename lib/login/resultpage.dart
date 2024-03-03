import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class ResultScreen extends StatefulWidget {
  final File imageFile;
  const ResultScreen({Key? key, required this.imageFile}) : super(key: key);
  @override
  _ResultScreenState createState() => _ResultScreenState();
}
class _ResultScreenState extends State<ResultScreen> {
  // Declare a String variable to store the text result
  String textResult = '';
  @override
  void initState() {
    super.initState();
    // Call the extractText method and assign the result to the variable
    extractText(widget.imageFile).then((value) {
      setState(() {
        textResult = value;
      });
    });
  }
  // Declare a bool variable to store the visibility state
  bool isVisible = false;
  // Define a method to toggle the visibility state
  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
  title: Align(
    alignment: Alignment.centerRight,
    child: Text(' Recognition Result', style: TextStyle(color: Colors.blue)),
  ),
  centerTitle: true,
 backgroundColor: Color.fromARGB(255, 204, 204, 204),
  leading: Padding(
    padding: EdgeInsets.all(5),
    child: CircleAvatar(
      backgroundImage: AssetImage('images/logo.png'),
    ),
  ),
),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the text extraction result
            Text(
              textResult,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // Use the visibility state to show or hide the comment and rating widgets
            Visibility(
              visible: isVisible,
              child: Column(
                children: [
                  TextField(
                    // Add a text field to allow the user to add a comment
                    decoration: InputDecoration(
                      hintText: 'Enter your comment here',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RatingBar.builder(
                    // Add a rating bar to allow the user to evaluate the result
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 219, 206, 19),
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
    Future<String> extractText(File imageFile) async {
      // Return a default message
      return 'Sorry, no text extracted';
    } 
   }