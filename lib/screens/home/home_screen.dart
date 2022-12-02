import 'package:flutter/material.dart';
import 'package:links_directory/screens/home/widgets/body.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Links Directory"),
        actions: [
          TextButton(
            onPressed: () async {
              await launch("https://forms.gle/XH4yUCxco3UdeubW7");
            },
            child: const Text(
              "Feedback",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: const Body(),
    );
  }
}
