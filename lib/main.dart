// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive_project/screens/home_page.dart';
// import 'package:hive_project/screens/signup_page.dart';
// import 'package:hive_project/screens/login_page.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   await Hive.openBox('usersBox'); // ✅ Opening the box once
//   runApp(const HiveApp());
// }

// class HiveApp extends StatelessWidget {
//   const HiveApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/login',
//       routes: {
//         '/signup': (context) => const SignupPage(),
//         '/login': (context) => const LoginPage(),
//         '/home': (context) => const HomePage(),
//       },
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive_project/screens/login_page.dart';
// import 'package:hive_project/screens/signup_page.dart';
// import 'package:hive_project/screens/home_page.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   await Hive.openBox('usersBox'); // User data
//   await Hive.openBox('sessionBox'); // ✅ New: For session login flag

//   runApp(const HiveApp());
// }

// class HiveApp extends StatelessWidget {
//   const HiveApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final sessionBox = Hive.box('sessionBox');
//     final bool isLoggedIn = sessionBox.get('isLoggedIn', defaultValue: false);

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute:
//           isLoggedIn ? '/home' : '/login', // ✅ Go to Home if logged in
//       routes: {
//         '/login': (context) => const LoginPage(),
//         '/signup': (context) => const SignupPage(),
//         '/home': (context) => const HomePage(),
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_project/screens/login_page.dart';
import 'package:hive_project/screens/signup_page.dart';
import 'package:hive_project/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('usersBox');
  await Hive.openBox('sessionBox'); // ✅ NEW: for session

  final sessionBox = Hive.box('sessionBox');
  final isLoggedIn = sessionBox.get(
    'isLoggedIn',
    defaultValue: false,
  ); // ✅ check session

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? '/home' : '/login', // ✅ auto login
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
