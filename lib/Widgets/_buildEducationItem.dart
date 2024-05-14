import 'package:flutter/material.dart';

class EducationItem extends StatelessWidget {
  final String title;
  final String duration;
  final String description;
  final String imagePath;

  const EducationItem({
    Key? key,
    required this.title,
    required this.duration,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Container(
        width: 120, // Adjust the width as needed
        height: 120, // Adjust the height as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Color.fromARGB(255, 182, 93, 197),
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            duration,
            style: TextStyle(
              color: Color.fromARGB(
                255,
                151,
                146,
                173,
              ),
            ),
          ),
          SizedBox(
              height: 4), // Adjust spacing between duration and description
          Text(
            description,
            style: TextStyle(
                // No explicit color set, will inherit from the theme
                ),
          ),
        ],
      ),
    );
  }
}
