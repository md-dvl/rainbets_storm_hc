import 'package:flutter/cupertino.dart';

class AppColors {
  // Deep navy background
  static const Color deepNavy = Color.fromRGBO(3, 7, 46, 1.0);
  
  // Light gray accent
  static const Color lightGrayAccent = Color.fromRGBO(189, 191, 199, 1.0);
  
  // Medium blue tone
  static const Color mediumBlue = Color.fromRGBO(57, 59, 88, 1.0);
  
  // White primary text
  static const Color whitePrimary = Color.fromRGBO(244, 245, 245, 1.0);
  
  // Neutral gray-blue element
  static const Color neutralGrayBlue = Color.fromRGBO(123, 125, 143, 1.0);
  
  // Gradients
  static const LinearGradient navyToBlueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [deepNavy, mediumBlue],
  );
  
  static const LinearGradient blueToNavyGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [mediumBlue, deepNavy],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [mediumBlue, Color.fromRGBO(40, 42, 70, 1.0), deepNavy],
  );
  
  static const LinearGradient stormGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(20, 25, 60, 1.0),
      mediumBlue,
      deepNavy,
    ],
  );
}

