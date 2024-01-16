import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class introscreen extends StatelessWidget {
  const introscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Sunny weather",
            body: "weather app in this app you can see the sunny weather ",
            image: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/2.gif",
                  ),
                ),
              ),
            ),
          ),
          PageViewModel(
            title: "weather app",
            body: "here you can search about any city in the india",
            image: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/1.png",
                  ),
                ),
              ),
            ),
          ),
          PageViewModel(
            title: "rainy seasons",
            body: "you can also see the where and when the rain was coming",
            image: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/3.jpeg",
                  ),
                ),
              ),
            ),
          ),
          PageViewModel(
            title: "weather app",
            body: "here you can search anything about weather through api",
            image: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/4.jpeg",
                  ),
                ),
              ),
            ),
          ),
        ],
        onDone: () async {
          Navigator.pushReplacementNamed(context, 'home');
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setBool("Isvisited", true);
        },
        done: const Text("Done"),
        showNextButton: true,
        next: const Text("Next"),
      ),
    );
  }
}
