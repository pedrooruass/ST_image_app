import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_app/src/core/models/photo_model.dart';
import 'package:image_app/src/screens/second_screen/second_screen.dart';

class MainScreen extends StatefulWidget {
// 1- Comunicar com o servidor - ok
// 2- receber a resposta e ver se deu certo - ok
// 3- converter o json para um map - ok
// 4- criar uma classe com factory '.fromMap()' - ok
// 5- criar lista e instanciar nela - ok
// 6- brincar - ok

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<PhotoModel> photos = [];
  bool isLoading = false;

  getImages() async {
    setState(() {
      isLoading = true;
    });
    http.Response response =
        await http.get("https://jsonplaceholder.typicode.com/photos");
    if (response.statusCode == 200) {
      final convertedToMap = json.decode(response.body);
      setState(() {
        photos = (convertedToMap as List).map((e) {
          return PhotoModel.fromMap(e);
        }).toList();
      });

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Photos App",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Visibility(
        visible: !isLoading,
        /* -------------------------------------------------------------------------- */
        child: GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            // So pra ele estar ai
            childAspectRatio: 1,
          ),
          itemCount: photos.length,
          itemBuilder: (_, index) {
            return squareTile(
                title: photos[index].title, thumbnailURL: photos[index].thumbnailUrl, url: photos[index].url);
          },
        ),
        /* -------------------------------------------------------------------------- */
        replacement: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/loading_image.jpg", height: 150, width: 150),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: CircularProgressIndicator(),
              ),
              Text(
                "Loading...",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget squareTile({String title, String thumbnailURL, String url}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return SecondScreen(
                title: title,
                url: url,
              );
            },
          ),
        );
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(thumbnailURL), fit: BoxFit.cover),
        ),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// GridView(
//           padding: EdgeInsets.all(10),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 10,
//             crossAxisSpacing: 10,
//             // So pra ele estar ai
//             childAspectRatio: 1,
//           ),
//           children: photos.map((e) {
//             return squareTile(
//                 title: e.title, thumbnailURL: e.thumbnailUrl, url: e.url);
//           }).toList(),
//         ),
