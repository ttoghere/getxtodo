import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension PercentSized on double {
  //For using responsive settings of every screen type
  double get hp => (Get.height * (this / 100));
  double get wp => (Get.width * (this / 100));
}

extension ResponsiveText on double {
  //For using responsive settings of every screen
  double get sp => Get.width / 100 * (this / 3);
}

extension HexColor on Color {
  //Converts string to color
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    //if the strings length are 6 or 7 than automatically adds ff
    //That function helps to make Color(0xFF......);
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
  //Coverts the statement to String color code
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
  //I Will look to that
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
