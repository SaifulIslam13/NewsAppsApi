import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

mystyle(double fontsize, Color clr, [FontWeight? fw]) {
  return GoogleFonts.roboto(
    fontSize: fontsize,
    fontWeight: fw,
    color: clr,
  );
}
