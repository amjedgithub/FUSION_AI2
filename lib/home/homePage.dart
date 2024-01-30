import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
			appBar: AppBar(
				title: Text("Home Page"),
				actions: [IconButton(onPressed: () async{
					await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacementNamed('login');
				}, icon:Icon(Icons.exit_to_app) )],
			),
			body: ListView(
				children: [

				],
			),
		);
  }
}
