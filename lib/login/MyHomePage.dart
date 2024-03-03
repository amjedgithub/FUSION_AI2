import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'resultPage.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
  title: Align(
    alignment: Alignment.centerRight,
    child: Text(' Home', style: TextStyle(color: Colors.blue)),
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
            const Text(
              'Welcome to FUSION AI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'The easiest way to extract text from any image',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
           const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Show a modal bottom sheet with options for image source
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 200,
                      child: Column(
                        children: [
                          Text('Choose an image source'),
                          ElevatedButton(
                            onPressed: () async {
                              // Pick an image from the gallery
                              XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              // Navigate to the result screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                      imageFile: File(image!.path)),
                                ),
                              );
                            },
                            child: Text('Gallery'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // Pick an image from the camera
                              XFile? image = await _picker.pickImage(
                                  source: ImageSource.camera);
                              // Navigate to the result screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                      imageFile: File(image!.path)),
                                ),
                              );
                            },
                            child: Text('Camera'),
                          ),
                        ],
                      ),
                    );
                  },
                ); // Add this parenthesis
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Select an Image'),
            ),
          ],
        ),
      ),
    );
  }
}
