import 'package:flutter/material.dart';

class CardTop extends StatelessWidget {
  final bool isColor;
  final String text;
  final IconData icon;
  final Widget page;

  const CardTop({
    required this.isColor,
    required this.text,
    required this.icon,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = isColor ? Color(0xff1F1E25) : Colors.white;
    final Color textColor = isColor ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: () => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, _, child) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: child,
            );
          },
        ),
      ),
      child: Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(this.icon, color: textColor, size: 35),
            SizedBox(height: 6),
            Text(this.text, style: TextStyle(color: textColor, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
