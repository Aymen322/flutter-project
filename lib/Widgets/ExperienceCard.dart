import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExperienceCard extends StatelessWidget {
  final String title;
  final String duration;
  final String description;
  final String imagePath;
  final String url;

  const ExperienceCard({
    Key? key,
    required this.title,
    required this.duration,
    required this.description,
    required this.imagePath,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (url.isNotEmpty) {
              launchURL(url);
            }
          },
          child: Image.asset(imagePath),
        ),
        const SizedBox(height: 8.0),
        Text(
          title,
          style: TextStyle(
            color: Color.fromARGB(255, 182, 93, 197), // Set title color here
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(duration),
        Text(description),
        const Divider(),
        const SizedBox(height: 20.0),
      ],
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
