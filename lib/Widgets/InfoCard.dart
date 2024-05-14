import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String text;
  final String value;
  final Function()? onTap;
  final bool showClickMessage;

  const InfoCard({
    required this.text,
    required this.value,
    this.onTap,
    this.showClickMessage = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              text,
              style: TextStyle(
                color:
                    Color.fromARGB(255, 182, 93, 197), // Set title color here
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value),
                if (showClickMessage) SizedBox(height: 4),
                if (showClickMessage)
                  Text(
                    "Click to view",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
