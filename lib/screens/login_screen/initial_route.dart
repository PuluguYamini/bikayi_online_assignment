import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bikayi_project/screens/login_screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InitialRoute extends StatefulWidget {
  const InitialRoute({Key key}) : super(key: key);

  @override
  _InitialRouteState createState() => _InitialRouteState();
}

class _InitialRouteState extends State<InitialRoute> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Container(
          color: Colors.black.withOpacity(0.8),
          child: Stack(
            children: [
              IntroScreen(),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.5),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 150),
                child: Text('Hello User!', style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 30, )),
              ),
              InkWell(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 70),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      ScaleAnimatedText('Tap to continue',scalingFactor: 0.2,
                          textStyle: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 20)),
                    ],
                  )
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentPage=0;
  final image = [
    'assets/bikayi_images/albert.jpg',
    'assets/bikayi_images/obamaa.jpeg',
    'assets/bikayi_images/tagore.jpeg',
    'assets/bikayi_images/teresa.jpeg',
  ];

  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      setState(() {
        currentPage = (currentPage + 1) % image.length;
      });

    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image[(currentPage + 1) % image.length]),
                fit: BoxFit.cover,
              )
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image[currentPage]),
                fit: BoxFit.cover,
              )
          ),
        ),
      ],
    );
  }
}

