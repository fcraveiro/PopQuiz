import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mensagem(context, texto) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color(0xFFFF9E1B),
      content: Container(
        height: 25,
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              texto,
              style: GoogleFonts.roboto(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.only(bottom: 22, top: 22),
    ),
  );
}
