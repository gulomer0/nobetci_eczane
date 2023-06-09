import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart' as Lottie;
import 'package:nobetci_eczane/DetaySayfa.dart';
import 'package:http/http.dart' as http;

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
  late Future<List<dynamic>> provinces;
  late Future<List<dynamic>> districts;

  String? selectedProvince;
  String? selectedDistrict;

  Future<List<dynamic>> getProvinces() async {
    final response = await http
        .get(Uri.parse('https://turkiyeapi.cyclic.app/api/v1/provinces'));
    final parsed = jsonDecode(response.body);
    return parsed['data'].map((province) => province).toList();
  }

  Future<List<dynamic>> getDistricts(String provinceName) async {
    final response = await http.get(Uri.parse(
        'https://turkiyeapi.cyclic.app/api/v1/provinces?name=$provinceName'));
    final parsed = jsonDecode(response.body);
    return parsed['data'][0]['districts'].map((district) => district).toList();
  }

  void initState() {
    super.initState();
    provinces = getProvinces();
    districts = Future.value([]);
  }

  void _onProvinceSelected(String? value) {
    setState(() {
      selectedProvince = value;
      selectedDistrict = null;
      districts =
          value != null ? getDistricts(value) : Future.value([]);
    });
  }

  void _onDistrictSelected(String? value) {
    setState(() {
      selectedDistrict = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text("Hangi Eczane"),
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
              child: FutureBuilder<List<dynamic>>(
                future: provinces,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: "İl Seçiniz",
                      ),
                      value: selectedProvince,
                      onChanged: _onProvinceSelected,
                      items: snapshot.data!.map((province) {
                        return DropdownMenuItem<String>(
                          value: province['name'],
                          child: Text(province['name']),
                        );
                      }).toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 30.0, right: 30.0, bottom: 8.0),
              child: FutureBuilder<List<dynamic>>(
                future: districts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: "İlçe Seçiniz",
                      ),
                      value: selectedDistrict,
                      onChanged: _onDistrictSelected,
                      items: snapshot.data!.map((district) {
                        return DropdownMenuItem<String>(
                          value: district['name'],
                          child: Text(district['name']),
                        );
                      }).toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return const CircularProgressIndicator();
                },
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

                if(selectedProvince == null || selectedDistrict == null){
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetaySayfa(
                            ilArama: selectedProvince,
                            ilceArama: selectedDistrict,
                          )),
                );        
              },
              child: Icon(Icons.search),
            ),
          ],
        ),
      )),
    );
  }
}
