import 'package:flutter/material.dart';

class ProjectItem extends StatelessWidget {
  final String title;
  final String description;
  final List<String> skills;
  final bool isDarkMode; // Added parameter to determine dark mode
  final IconData iconData; // Added parameter for framework icon

  const ProjectItem({
    Key? key,
    required this.title,
    required this.description,
    required this.skills,
    required this.isDarkMode, // Added parameter
    required this.iconData, // Added parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color chipColor = isDarkMode
        ? Color.fromRGBO(174, 119, 184, 1)
        : Color.fromRGBO(156, 39, 176, 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: chipColor, // Set title color to chipColor
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          children: skills.map((skill) {
            IconData iconData = Icons.code; // Default icon
            String label = skill;

            return Chip(
              avatar: Icon(
                iconData,
                color: chipColor,
              ),
              label: Text(
                label,
                style: TextStyle(
                  color: chipColor,
                ),
              ),
              backgroundColor:
                  isDarkMode ? Colors.transparent : chipColor.withOpacity(0.1),
            );
          }).toList(),
        ),
      ],
    );
  }
}
