import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_project/screens/signup_page.dart';
import 'package:hive_project/screens/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const routename = '/login';
  bool isChecked = false;

  // ✅ ADDED: Controllers for email and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ✅ ADDED: Function to show a SnackBar message
  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // ✅ ADDED: Login Logic
  void loginUser() {
    String email = emailController.text.trim();
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showMessage("Please fill in all fields");
      return;
    }

    var box = Hive.box('usersBox');

    if (!box.containsKey(email)) {
      showMessage("User not found");
      return;
    }

    String storedPassword = box.get(email);

    if (password != storedPassword) {
      showMessage("Incorrect password");
      return;
    }

    // final sessionBox = Hive.box('sessionBox'); // ✅ NEW
    // sessionBox.put('isLoggedIn', true);
    // sessionBox.put('currentUserEmail', email);

    // ✅ Save session only if "Remember me" is checked
    if (isChecked) {
      final sessionBox = Hive.box('sessionBox'); // ✅ NEW

      sessionBox.put('isLoggedIn', true);
      sessionBox.put('currentUserEmail', email);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
    showMessage("Login successful!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF011B30),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Log In ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),

            // ✅ MODIFIED: Attached controller to email field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: emailController, // ✅
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black26,
                  labelText: 'Email',
                  hintText: 'Enter your Email',
                  hintStyle: const TextStyle(color: Colors.white54),
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blueAccent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.lightBlue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ✅ MODIFIED: Attached controller to password field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: passwordController, // ✅
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black26,
                  labelText: 'Password',
                  hintText: 'Enter your Password',
                  hintStyle: const TextStyle(color: Colors.white54),
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blueAccent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.lightBlue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Remember Me Checkbox
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isChecked ? Colors.green : Colors.white,
                          width: 2,
                        ),
                        color: isChecked ? Colors.green : Colors.transparent,
                      ),
                      child:
                          isChecked
                              ? const Icon(
                                Icons.check,
                                size: 18,
                                color: Colors.white,
                              )
                              : null,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Remember me ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ✅ MODIFIED: Login button with logic
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: ElevatedButton(
                  onPressed: loginUser, // ✅
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF0C13FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Sign Up Navigation
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_project/screens/signup_page.dart';
// import 'package:hive_project/screens/home_page.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   static const routename = '/login';
//   bool isChecked = false;

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   void showMessage(String message) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }

//   void loginUser() {
//     String email = emailController.text.trim();
//     String password = passwordController.text;

//     if (email.isEmpty || password.isEmpty) {
//       showMessage("Please fill in all fields");
//       return;
//     }

//     var box = Hive.box('usersBox');

//     if (!box.containsKey(email)) {
//       showMessage("User not found");
//       return;
//     }

//     // ✅ FIXED: Match password from the stored map
//     final userData = box.get(email);
//     if (userData is! Map || !userData.containsKey('password')) {
//       showMessage("Invalid user data");
//       return;
//     }

//     if (userData['password'] != password) {
//       showMessage("Incorrect password");
//       return;
//     }

//     showMessage("Login successful!");

//     // ✅ FIXED: Navigate to home screen
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const HomePage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0XFF011B30),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 80, left: 20),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: const Text(
//                   'Log In ',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 35,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 100),

//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: TextField(
//                 controller: emailController,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.black26,
//                   labelText: 'Email',
//                   hintText: 'Enter your Email',
//                   hintStyle: const TextStyle(color: Colors.white54),
//                   labelStyle: const TextStyle(color: Colors.white),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                       color: Colors.blueAccent,
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                       color: Colors.lightBlue,
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 40),

//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: TextField(
//                 controller: passwordController,
//                 obscureText: true,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.black26,
//                   labelText: 'Password',
//                   hintText: 'Enter your Password',
//                   hintStyle: const TextStyle(color: Colors.white54),
//                   labelStyle: const TextStyle(color: Colors.white),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                       color: Colors.blueAccent,
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                       color: Colors.lightBlue,
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 17,
//                     vertical: 10,
//                   ),
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         isChecked = !isChecked;
//                       });
//                     },
//                     child: Container(
//                       width: 24,
//                       height: 24,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: isChecked ? Colors.green : Colors.white,
//                           width: 2,
//                         ),
//                         color: isChecked ? Colors.green : Colors.transparent,
//                       ),
//                       child:
//                           isChecked
//                               ? const Icon(
//                                 Icons.check,
//                                 size: 18,
//                                 color: Colors.white,
//                               )
//                               : null,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 const Text(
//                   'Remember me ',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),

//             SizedBox(
//               width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 40, right: 40),
//                 child: ElevatedButton(
//                   onPressed: loginUser,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0XFF0C13FF),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     'Log in',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             Row(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.only(left: 40),
//                   child: Text(
//                     'Don\'t have an account?',
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/signup');
//                   },
//                   child: const Text(
//                     'Sign Up',
//                     style: TextStyle(
//                       color: Colors.blueAccent,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
