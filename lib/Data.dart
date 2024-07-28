import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const headColor = Color(0xFF0C54BE);
const backgroundColor = Color(0xFFF5F9FD);
const textColor = Color(0xFF303f60);
const blurTextColor = Color(0xFFced3dc);
const textBgColor = Colors.white;
const textOutlineColor = Colors.white;
// TextStyle defaultTextStyle (){
//   return GoogleFonts.getFont("Poppins",fontSize: );
// }
InputDecoration inputDecoration(String label){
  return InputDecoration(
    labelText: label,
    filled: true,
    fillColor: textBgColor,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: textOutlineColor
        ),
        borderRadius: BorderRadius.circular(16)
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: textOutlineColor
        ),
        borderRadius: BorderRadius.circular(16)
    ),
    border: OutlineInputBorder(
        borderSide: BorderSide(
            color: textOutlineColor
        ),
        borderRadius: BorderRadius.circular(16)
    ),                );
}
