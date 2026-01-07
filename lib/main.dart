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
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Configuration
                const int cols = 4;
                const int rows = 4; // You have 16 items (4 cols x 4 rows)
                const double horizontalPadding = 12.0;

                // Calculate exact dimensions
                final double itemWidth = (constraints.maxWidth - (horizontalPadding * 2)) / cols;
                final double itemHeight = constraints.maxHeight / rows;

                return GridView.count(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  crossAxisCount: cols,
                  childAspectRatio: itemWidth / itemHeight,
                  physics: const NeverScrollableScrollPhysics(),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
    Widget _buildButton(BuildContext context, String text) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate the size of the square based on the smaller dimension
        // minus some padding/spacing
        final double size = (constraints.maxWidth < constraints.maxHeight
                ? constraints.maxWidth
                : constraints.maxHeight) - 16.0; // 16.0 is spacing

        return Center(

          child: SizedBox(
            width: size,
            height: size,
            child: TextButton(
              onPressed: () => {
                Provider.of<CalculatorProvider>(context, listen: false).onBtnPress(text)
              },
              style: TextButton.styleFrom(
                 shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                 ),
              ),
              child: Text(text, style: Theme.of(context).textTheme.labelLarge),
            ),
          ),
        );
      },
    );
  }
}