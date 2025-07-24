import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool isChecked = false;
  bool obscurePassword = true;
  bool isTappedinsta = false;
  bool isTappedfb = false;
  bool isTappedgoogle = false;
  bool isAnyTapped = false;
  bool loginTapped = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

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

    if (isChecked) {
      final sessionBox = Hive.box('sessionBox');

      sessionBox.put('isLoggedIn', true);
      sessionBox.put('currentUserEmail', email);
    }
    Navigator.pushNamed(context, ('/home'));
    showMessage("Login successful!");
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    final email = emailController.text.trim();
    final userBox = Hive.box('usersBox');

    if (value == null || value.isEmpty) {
      return 'Please enter your Password';
    } else if (userBox.containsKey(email)) {
      String storedPassword = userBox.get(email);
      if (value != storedPassword) {
        return 'Incorrect password';
      }
    }
    return null;
  }

  void handleTapInsta() async {
    if (isAnyTapped) return;

    setState(() {
      isAnyTapped = true;
      isTappedinsta = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Instagram login not implemented yet")),
    );

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      isAnyTapped = false;
      isTappedinsta = false;
    });
  }

  void handleTapFb() async {
    if (isAnyTapped) return;

    setState(() {
      isAnyTapped = true;
      isTappedfb = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Facebook login not implemented yet")),
    );

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      isAnyTapped = false;

      isTappedfb = false;
    });
  }

  void handleTapGoogle() async {
    if (isAnyTapped) return;

    setState(() {
      isAnyTapped = true;
      isTappedgoogle = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Google login not implemented yet")),
    );

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      isAnyTapped = false;
      isTappedgoogle = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF011B30),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80, left: 20),
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: const Text('Sign in ', style: kHeadingSignInTextStyle),
                ),
              ),
              const SizedBox(height: 100),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),

                child: TextFormField(
                  validator: validateEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black26,
                    labelText: 'Email',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Enter your Email',
                    hintStyle: const TextStyle(color: Colors.white54),
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blueAccent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: passwordController,
                        validator: validatePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: obscurePassword,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black26,
                          labelText: 'Password',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Enter your Password',
                          hintStyle: const TextStyle(color: Colors.white54),
                          labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blueAccent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

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
                        width: 15,
                        height: 15,
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
                                  size: 10,
                                  color: Colors.white,
                                )
                                : null,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: const Text(
                      'Remember me ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: ElevatedButton(
                    onPressed:
                        loginTapped
                            ? null
                            : () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loginTapped = true;
                                });

                                await Future.delayed(
                                  const Duration(seconds: 3),
                                );

                                loginUser();
                                setState(() {
                                  loginTapped = false;
                                });
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF0C13FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child:
                        loginTapped
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: Colors.white,
                              ),
                            )
                            : const Text(
                              'Sign in',
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

              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
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
              const SizedBox(height: 20),
              Text(
                ' OR Sign in With',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: handleTapInsta,
                      child: CircleAvatar(
                        radius: 30,

                        backgroundImage: AssetImage('assets/images/insta.png'),

                        child:
                            isTappedinsta
                                ? const CircularProgressIndicator(
                                  color: Colors.blue,
                                  strokeWidth: 3,
                                )
                                : null,
                      ),
                    ),
                    SizedBox(width: 40),
                    TextButton(
                      onPressed: handleTapFb,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/fb.png'),
                        child:
                            isTappedfb
                                ? const CircularProgressIndicator(
                                  color: Colors.blue,
                                  strokeWidth: 3,
                                )
                                : null,
                      ),
                    ),
                    SizedBox(width: 40),
                    TextButton(
                      onPressed: handleTapGoogle,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                          'assets/images/googleicon.png',
                        ),
                        child:
                            isTappedgoogle
                                ? const CircularProgressIndicator(
                                  color: Colors.blue,
                                  strokeWidth: 3,
                                )
                                : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
