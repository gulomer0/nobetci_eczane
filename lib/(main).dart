/* import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart' as Lottie;
import 'package:nobetci_eczane/DetaySayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var ilArama = TextEditingController();
  var ilceArama = TextEditingController();

  List<String> _cities = ['İstanbul', 'Ankara', 'İzmir', 'Bursa']; // Seçilebilecek şehirlerin listesi.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text("Nöbetçi Eczane"),
          backgroundColor: Color.fromRGBO(0, 113, 188, 1)),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Lottie.Lottie.asset("lottie/pharmacy.json"),
            Padding(
              padding: const EdgeInsets.only(
                  top: 70.0, left: 30.0, right: 30.0, bottom: 8.0),
              child: TextField(
                controller: ilArama,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'İl',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 30.0, right: 30.0, bottom: 8.0),
              child: TextField(
                controller: ilceArama,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'İlçe',
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                  elevation: MaterialStateProperty.all<double>(0.0),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(0, 113, 188, 1))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetaySayfa(
                            ilArama: ilArama.text, ilceArama: ilceArama.text)));
              },
              child: Icon(Icons.search),
            ),
          ],
        ),
      )),
    );
  }
}*/
