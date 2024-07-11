import 'package:flutter/material.dart';
import 'todo_list_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigate to the TodoListPage after a 5-second delay
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TodoListPage()));
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sp.png'), // Path to your splash image
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
