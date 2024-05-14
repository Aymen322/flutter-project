import 'package:flutter/material.dart';

class CardCustom extends StatelessWidget{
  final  String text;
  final String education;
  final Color colorIcon;
  final bool isEducation;

   const CardCustom({super.key, 
    required this.colorIcon,
     required this.text,
     this.isEducation = true ,
    this.education ='',
    
  
  });
  
  @override
  Widget build(BuildContext context) {
  return Padding (
    padding: const EdgeInsets.only(bottom: 25.0),
    child: Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xff1F1E25),
        borderRadius: BorderRadius.circular(20.0)
  ),
  child: Row(
    children: [
      Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: colorIcon,
          borderRadius: BorderRadius.circular(15.0)
      ),
      child: const Icon(Icons.work_outline_outlined , color:Colors.white),
    ),
    const SizedBox(width: 15.0),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text , style :const TextStyle(color :Colors.white , fontSize: 16)),
        const SizedBox(height: 7.0),
        !isEducation
        ? const Text('2020-New .Lima -PE' , style: TextStyle(color: Colors.grey , fontSize: 15))
        : Text (education , style : const TextStyle(color: Colors.grey , fontSize: 15))
      ],
    )
    ],
    ),
    ),
  );
  }

}