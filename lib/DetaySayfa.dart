import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nobetci_eczane/EczanelerApi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:maps_launcher/maps_launcher.dart';

class DetaySayfa extends StatefulWidget {
  var ilArama;
  var ilceArama;

  DetaySayfa({this.ilArama, this.ilceArama});

  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  Future<Eczaneler> aramaYap(String ilArama, String ilceArama) async {
    var url = Uri.parse(
        "https://api.collectapi.com/health/dutyPharmacy?ilce=${ilceArama}&il=${ilArama}");
    //https://api.collectapi.com/health/dutyPharmacy?ilce=%C3%87ankaya&il=Ankara
    var response = await http.get(url, headers: {
      'Authorization': 'apikey 1Djuv5aGeWJbuue5aWH3bA:2suqPREUSuAyIKSZ3RrirL',
      'Content-Type': 'application/json'
    });
    return Eczaneler.fromJson(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text("Nöbetçi Eczaneler"),
          backgroundColor: Color.fromRGBO(0, 113, 188, 1)),
      body: FutureBuilder(
        future: aramaYap(widget.ilArama, widget.ilceArama),
        builder: (context, AsyncSnapshot<Eczaneler> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 2.3),
                itemCount: snapshot.data!.result.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                  width: 125,
                                  child: Image.asset("image/pharmacy.png")),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        snapshot.data!.result[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: SizedBox(
                                    width: 150,
                                    child: Text(
                                      snapshot.data!.result[index].address,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () => MapsLauncher.launchQuery(
                                        '${snapshot.data!.result[index].address}'),
                                    icon: Icon(Icons.location_on,
                                        color: Colors.redAccent, size: 35)),
                                IconButton(
                                    onPressed: () {
                                      FlutterPhoneDirectCaller.callNumber(
                                          snapshot.data!.result[index].phone);
                                    },
                                    icon: Icon(Icons.phone,
                                        color: Colors.greenAccent, size: 35)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
