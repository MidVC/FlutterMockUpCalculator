import 'package:flutter/material.dart';
import 'calculator_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
  create: (context) => CalculatorProvider(),
  child: const CalculatorApp(),),);

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      // Light theme
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.black, fontSize: 48, fontWeight: FontWeight.bold),
          labelLarge: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      // Dark theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Color.fromARGB(255, 93, 92, 92), fontSize: 48, fontWeight: FontWeight.bold),
          labelLarge: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Output display
          Selector<CalculatorProvider, String>(
            selector: (context, calc) => calc.display,
            builder: (context, display, child) => Container(
              height: 200,
              padding: const EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Text(display, style: Theme.of(context).textTheme.displayLarge),
            ),
          ),
          // Buttons keypad
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton(context, "7"),
                      _buildButton(context, "8"),
                      _buildButton(context, "9"),
                      _buildButton(context, "×"),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton(context, "4"),
                      _buildButton(context, "5"),
                      _buildButton(context, "6"),
                      _buildButton(context, "÷"),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton(context, "1"),
                      _buildButton(context, "2"),
                      _buildButton(context, "3"),
                      _buildButton(context, "-"),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPlaceholder(context),
                      _buildButton(context, "0"),
                      _buildButton(context, "="),
                      _buildButton(context, "+"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // Build a button with the given text
  Widget _buildButton(BuildContext context, String text) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonSize = screenWidth * 0.22; // Adjust to ~18% of screen width
    
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: TextButton(
        onPressed: () => {
          context.read<CalculatorProvider>().onBtnPress(text)
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(buttonSize / 3)),
          ),
        ),
        child: Text(text, style: Theme.of(context).textTheme.labelLarge),
      ),
    );
  }
  // Placeholder for the empty space between the buttons
  Widget _buildPlaceholder(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonSize = screenWidth * 0.22; // Adjust 
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
    );
  }
}