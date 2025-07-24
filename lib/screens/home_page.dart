import 'package:flutter/material.dart';
import 'package:flutter_hive_test/screens/constants.dart';
import 'package:hive/hive.dart';
import 'logoutpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showEmailDialog() async {
    final box = await Hive.openBox('usersBox');
    final emails = box.keys.toList();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Saved Accounts"),
            content: SizedBox(
              width: double.maxFinite,
              height: 200,
              child: ListView.builder(
                itemCount: emails.length,
                itemBuilder: (context, index) {
                  final email = emails[index].toString();
                  return ListTile(
                    leading: const Icon(Icons.email),
                    title: Text(email),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome to the Home Page!', style: kWelcomeTextStyle),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  LogoutDialog.show(context);
                },
                child: const Text('LOG OUT'),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: showEmailDialog,
                child: const Text('Show Saved Emails'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
