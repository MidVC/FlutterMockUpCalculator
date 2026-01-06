import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  String _display = '0';
  double? _firstOperand;
  String? _operator;
  bool _shouldReset = false;
  String get display => _display;

  void onBtnPress(String value) {
    if (value == "+" || value == "-" || value == "×" || value == "÷") {
      _firstOperand = double.parse(_display);
      _operator = value;
      _shouldReset = true;
    } else if (value == "=") {
      _calculate();
    } else {
      if (_display == "0" || _shouldReset) {
        _display = value;
        _shouldReset = false;
      } else {
        _display += value;
      }
    }
    notifyListeners();
  }

  void _calculate() {
    if (_operator != null && _firstOperand != null) {
      double secondOperand = double.parse(_display);
      double result = 0;
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
      _display = result % 1 == 0 ? result.toInt().toString() : result.toString();
    }
  }
}