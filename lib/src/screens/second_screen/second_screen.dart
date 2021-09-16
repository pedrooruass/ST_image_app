import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String title;
  final String url;

  SecondScreen({
    this.title,
    this.url,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Image.network(url),
      ),
    );
  }
}
