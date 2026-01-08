import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  var display = "0";
  double? _firstOperand;
  String? _operator;
  var _shouldReset = false;

  void onBtnPress(String value) {
    if (value == "+" || value == "-" || value == "×" || value == "÷") {
      _firstOperand = double.tryParse(display) ?? 0.0;
      _operator = value;
      _shouldReset = true;
    } else if (value == "=") {
      _calculate();
    } else {
      if (display == "0" || _shouldReset) {
        display = value;
        _shouldReset = false;
      } else {
        display += value;
      }
    }
    notifyListeners();
  }

  void _calculate() {
    if (_operator != null && _firstOperand != null) {
      final secondOperand = double.tryParse(display) ?? 0.0;
      var result = 0.0;
      switch (_operator) {
        case "+":
          result = _firstOperand! + secondOperand;
          break;
        case "-":
          result = _firstOperand! - secondOperand;
          break;
        case "×":
          result = _firstOperand! * secondOperand;
          break;
        case "÷":
          result = _firstOperand! / secondOperand;
          break;
      }
      _firstOperand = null;
      _operator = null;
      display = result % 1 == 0 ? result.toInt().toString() : result.toString();
    }
  }
}