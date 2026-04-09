import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/form_screen.dart';
import 'screens/table_screen.dart';
import 'screens/alerts_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Enable semantics for automation tools like Playwright & Testsigma
  SemanticsBinding.instance.ensureSemantics();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practice App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/form': (context) => const FormScreen(),
        '/table': (context) => const TableScreen(),
        '/alerts': (context) => const AlertsScreen(),
      },
    );
  }
}
