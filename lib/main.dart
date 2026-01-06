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
    final calc = Provider.of<CalculatorProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          // Output display
          Container(
            height: 200,
            padding: const EdgeInsets.all(24),
            alignment: Alignment.bottomRight,
            child: Text(calc.display, style: Theme.of(context).textTheme.displayLarge),
          ),
          // Buttons keypad
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              crossAxisCount: 4,
              childAspectRatio: 1.0,
              children: [
                _buildButton(context, "7"),
                _buildButton(context, "8"),
                _buildButton(context, "9"),
                _buildButton(context, "×"),
                _buildButton(context, "4"),
                _buildButton(context, "5"),
                _buildButton(context, "6"),
                _buildButton(context, "÷"),
                _buildButton(context, "1"),
                _buildButton(context, "2"),
                _buildButton(context, "3"),
                _buildButton(context, "-"),
                const SizedBox.shrink(),
                _buildButton(context, "0"),
                _buildButton(context, "="),
                _buildButton(context, "+"),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildButton(BuildContext context, String text,) {
    return TextButton(
      onPressed: () => {
        Provider.of<CalculatorProvider>(context, listen: false).onBtnPress(text)
      },
      child: Text(text, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}