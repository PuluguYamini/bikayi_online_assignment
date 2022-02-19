import 'dart:convert';
import 'package:bikayi_project/screens/login_screen/login.dart';
import "dart:math";
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String name;
  const HomePage({Key key, this.name}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  T getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  List<dynamic> prizes = [];
  Set<dynamic> setPrizes = Set();
  var seen = Set<dynamic>();
  List<dynamic> uniquelist = [];
  bool isLoading = true;

  final String url = 'http://api.nobelprize.org/v1/prize.json';
  var client = http.Client();
  Future<void> fetchData() async {
    http.Response response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('----->>> connected'); // Connection Ok
      print('----->>> ${response.body}');
      Map<String, dynamic> map = json.decode(response.body);
      prizes = map["prizes"];
      uniquelist = prizes;
      setPrizes = prizes.toSet();
      setState(() {
        isLoading = false;
      });
      uniquelist.removeWhere((item) => !setPrizes.contains(item));
      print('>>>>>>>>> unique: ${uniquelist.length.toString()}');
      print('>>>>>>>>> setPrizes: ${setPrizes.length.toString()}');
      print('----->>> prizes in home page: $prizes');
      //print('----->>> prizes in home page: ${prizes.first.prizes}');
      print('----->>> prizes in home page: ${prizes?.length ?? 0}');
    } else {
      throw ('error');
    }
  }



  List<String> images = [
    'assets/bikayi_images/image_1.jpeg',
    'assets/bikayi_images/image_2.jpeg',
    'assets/bikayi_images/image_3.jpeg',
    'assets/bikayi_images/image_4.jpeg',
    'assets/bikayi_images/image_5.jpeg',
    'assets/bikayi_images/image_6.jpeg',
    'assets/bikayi_images/image_7.webp',
    'assets/bikayi_images/image_8.jpeg',
    'assets/bikayi_images/image_9.jpeg',
    'assets/bikayi_images/image_10.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
          endDrawer: appDrawer(),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                child: AppBar(
                  centerTitle: true,
                  title: Text('Nobel Prizes',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  leading: Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Text(
                        'Hey!',
                        textAlign: TextAlign.center,
                      )),
                  backgroundColor: Colors.black,
                ),
              )),
          body: SafeArea(
            bottom: false,
            child: Container(
                color: Colors.white,
                child: isLoading
                    ? Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : prizes?.length == null
                        ? new Container()
                        : ListView.builder(
                            itemCount: prizes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        //background color of box
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 2.0, // soften the shadow
                                          spreadRadius: 2.0, //extend the shadow
                                          offset: Offset(
                                            2.0, // Move to right 10  horizontally
                                            2.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ]),
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                    Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                              image: AssetImage(
                                                  getRandomElement(images)),
                                              fit: BoxFit.cover,
                                            )),
                                          ),
                                          const SizedBox(width: 15),
                                          Text(prizes[index]['category'][0].toUpperCase() +  prizes[index]['category'].substring(1)?? '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25)),
                                        ]),
                                        Text(prizes[index]['year']?? '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25)),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text('Winners',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 25)),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: prizes[index]['laureates'].length,
                                        itemBuilder: (BuildContext context, int index2) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(prizes[index]['laureates'][index2]['firstname'] ??
                                                  '',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 18)),
                                              const SizedBox(height: 3),
                                            ],
                                          );
                                        })
                                  ]));
                            },
                          )),
          )),
    );
  }

  Widget appDrawer() {
    return Drawer(
        child: ListView(shrinkWrap: true, padding: EdgeInsets.zero, children: [
      Stack(children: [
        Container(
            margin: const EdgeInsets.only(bottom: 80),
            padding: EdgeInsets.zero,
            height: 220,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/bikayi_images/noble_prise.jpeg'),
              fit: BoxFit.fill,
            ))),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
            child: InkWell(
              child: Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Positioned(
            top: 160,
            left: 0,
            right: 0,
            child: Align(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blueGrey,
                            border: Border.all(color: Colors.white)),
                        alignment: Alignment.center,
                        height: 110,
                        width: 100,
                        child: Text("${widget.name[0].toUpperCase()}",
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                    ])))
      ]),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
            "Hello! ${widget.name[0].toUpperCase() + widget.name.substring(1)}",
            style: TextStyle(
                color: Colors.black45,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: Text("We hope that you had great user experience!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            )),
      ),
      InkWell(
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => LoginPage()));
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.symmetric(vertical: 15),
          color: Colors.black,
          child: Text("Logout",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      )
    ]));
  }
}

List<PrizesData> usersFromJson(String str) =>
    List<PrizesData>.from(json.decode(str).map((x) => PrizesData.fromJson(x)));
String usersToJson(List<PrizesData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PrizesData {
  List<Prizes> prizes;

  PrizesData({this.prizes});

  PrizesData.fromJson(Map<String, dynamic> json) {
    if (json['prizes'] != null) {
      prizes = <Prizes>[];
      json['prizes'].forEach((v) {
        prizes.add(new Prizes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.prizes != null) {
      data['prizes'] = this.prizes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prizes {
  String year;
  String category;
  List<Laureates> laureates;
  String overallMotivation;

  Prizes({this.year, this.category, this.laureates, this.overallMotivation});

  Prizes.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    category = json['category'];
    if (json['laureates'] != null) {
      laureates = <Laureates>[];
      json['laureates'].forEach((v) {
        laureates.add(new Laureates.fromJson(v));
      });
    }
    overallMotivation = json['overallMotivation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['category'] = this.category;
    if (this.laureates != null) {
      data['laureates'] = this.laureates.map((v) => v.toJson()).toList();
    }
    data['overallMotivation'] = this.overallMotivation;
    return data;
  }
}

class Laureates {
  String id;
  String firstname;
  String surname;
  String motivation;
  String share;

  Laureates(
      {this.id, this.firstname, this.surname, this.motivation, this.share});

  Laureates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    surname = json['surname'];
    motivation = json['motivation'];
    share = json['share'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['surname'] = this.surname;
    data['motivation'] = this.motivation;
    data['share'] = this.share;
    return data;
  }
}
