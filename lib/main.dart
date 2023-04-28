import 'dart:convert';

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
  String selectedCity = "Ankara";
  String selectedDistrict = "Çankaya";

  final List<String> cities = [

    'Ankara',
    'İstanbul',
    'İzmir',
  ];

  final Map<String, List<String>> districts = {
    
    'Ankara': [
      'Çankaya',
      'Keçiören',
      'Mamak',
      'Yenimahalle',
    ],
    'İstanbul': [
      'Beşiktaş',
      'Kadıköy',
      'Şişli',
      'Üsküdar',
    ],
    'İzmir': [
      'Bornova',
      'Çiğli',
      'Karşıyaka',
      'Konak',
    ],
  };


  void updateDistricts(String city) {
    setState(() {
      selectedCity = city;
      selectedDistrict = districts[city]![0];
    });
  }

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
              child: DropdownButtonFormField(
                value: selectedCity,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: "İl Seçiniz",
                ),
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      selectedCity = value;
                    });
                  }
                  updateDistricts(value!);
                },
                items: cities.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 30.0, right: 30.0, bottom: 8.0),
                child: DropdownButtonFormField(
                  value: selectedDistrict,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: "İlçe Seçiniz",
                  ),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        selectedDistrict = value;
                      });
                    }
                  },
                  items: districts[selectedCity]!
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
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
                              ilArama: selectedCity,
                              ilceArama: selectedDistrict,
                            )));
              },
              child: Icon(Icons.search),
            ),
          ],
        ),
      )),
    );
  }
}
