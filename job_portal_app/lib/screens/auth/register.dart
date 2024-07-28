// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_app/models/authentication/user_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _passVisible = false;
  bool _passConfVisible = false;
  bool _registrationSuccess = false;

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final UserAuthenticationController _userAuthenticationController =
      Get.put(UserAuthenticationController());

  void validateAndRegister() async {
    bool hasError = false;
    if (_firstnameController.text.trim().isEmpty) {
      hasError = true;
      _userAuthenticationController.regError["firstname"] =
          "*firstname required";
    }
    if (_lastnameController.text.trim().isEmpty) {
      hasError = true;
      _userAuthenticationController.regError["lastname"] = "*lastname required";
    }
    if (_emailController.text.trim().isEmpty) {
      hasError = true;
      _userAuthenticationController.regError["email"] = "*email required";
    }
    if (_passwordController.text.trim().isEmpty) {
      hasError = true;
      _userAuthenticationController.regError["password"] = "*password required";
    }
    if (_confirmPasswordController.text.trim().isEmpty) {
      hasError = true;
      _userAuthenticationController.regError["confirm_password"] =
          "*confirm password";
    }
    if (_confirmPasswordController.text.trim() !=
        _passwordController.text.trim()) {
      _userAuthenticationController.regError["match_password"] =
          "*password doesn't match";
      hasError = true;
    }
    if (!hasError) {
      bool registrationSuccess = await _userAuthenticationController.register(
          firstname: _firstnameController.text.trim(),
          lastname: _lastnameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      _userAuthenticationController.regLoading.value = false;
      if (registrationSuccess) {
        setState(() {
          _registrationSuccess = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Registration failed. Please try again."),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 60, left: 25, right: 25),
            child: _registrationSuccess
                ? Column(
                    children: [
                      Center(
                        child: Text(
                          "Registration Successful!",
                          style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D0140)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Go back to login.",
                        style: GoogleFonts.poppins(color: Color(0xFF524B6B)),
                      ),
                      SizedBox(height: 40),
                      Image.asset("assets/icons/correct_icon.png", width: 140),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 266,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFF130160),
                          ),
                          child: Center(
                            child: Text("BACK TO LOGIN",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      Text("Create an Account",
                          style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D0140))),
                      SizedBox(height: 15),
                      Text("Set up a new account",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(color: Color(0xFF524B6B))),
                      SizedBox(height: 50),
                      Obx(() {
                        String? errorText =
                            _userAuthenticationController.regError["firstname"];
                        return TextFormField(
                          controller: _firstnameController,
                          decoration: InputDecoration(
                              hintText: errorText==null?"First Name":errorText,
                              hintStyle: TextStyle(
                                  color: errorText == null
                                      ? Color(0xFF0D0140)
                                      : Colors.red,
                                  fontFamily: GoogleFonts.poppins().fontFamily,fontSize: errorText==null?16:12),
                              contentPadding: EdgeInsets.all(16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18))),
                        );
                      }),
                      SizedBox(height: 15),
                      Obx(() {
                        String? errorText =
                            _userAuthenticationController.regError["lastname"];
                        return TextFormField(
                          controller: _lastnameController,
                          decoration: InputDecoration(
                              hintText:
                                  errorText == null ? "Last Name" : errorText,
                              hintStyle: TextStyle(
                                  color: errorText == null
                                      ? Color(0xFF0D0140)
                                      : Colors.red,
                                  fontFamily: GoogleFonts.poppins().fontFamily,fontSize: errorText==null?16:12),
                              contentPadding: EdgeInsets.all(16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18))),
                        );
                      }),
                      SizedBox(height: 15),
                      Obx(() {
                        String? errorText =
                            _userAuthenticationController.regError["email"];
                        return TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: errorText == null ? "Email" : errorText,
                              hintStyle: TextStyle(
                                  color: errorText == null
                                      ? Color(0xFF0D0140)
                                      : Colors.red,
                                  fontFamily: GoogleFonts.poppins().fontFamily,fontSize: errorText==null?16:12),
                              contentPadding: EdgeInsets.all(16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18))),
                        );
                      }),
                      SizedBox(height: 15),
                      Obx(() {
                        String? errorText =
                            _userAuthenticationController.regError["password"];
                        return TextFormField(
                          controller: _passwordController,
                          obscureText: !_passVisible,
                          decoration: InputDecoration(
                              hintText:
                                  errorText == null ? "Password" : errorText,
                              hintStyle: TextStyle(
                                  color: errorText == null
                                      ? Color(0xFF0D0140)
                                      : Colors.red,
                                  fontFamily: GoogleFonts.poppins().fontFamily,fontSize: errorText==null?16:12),
                              contentPadding: EdgeInsets.all(16),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _passVisible = !_passVisible;
                                    });
                                  },
                                  child: _passVisible
                                      ? Icon(
                                          Icons.visibility_outlined,
                                          color: Color(0xFF60778C),
                                        )
                                      : Icon(Icons.visibility_off_outlined,
                                          color: Color(0xFF60778C))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18))),
                        );
                      }),
                      SizedBox(height: 15),
                      Obx(() {
                        String? confirmPasswordError =
                            _userAuthenticationController
                                .regError["confirm_password"];
                        String? matchPasswordError =
                            _userAuthenticationController
                                .regError["match_password"];
                        String combinedError = '';
                        if (confirmPasswordError != null) {
                          combinedError += confirmPasswordError;
                        }
                        if (matchPasswordError != null) {
                          if (combinedError.isNotEmpty) {
                            combinedError += ' ';
                          }
                          combinedError += matchPasswordError;
                        }

                        return TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: !_passConfVisible,
                          decoration: InputDecoration(
                            hintText: combinedError.isEmpty
                                ? "Confirm Password"
                                : combinedError,
                            hintStyle: TextStyle(
                              color: combinedError.isEmpty
                                  ? Color(0xFF0D0140)
                                  : Colors.red,
                              fontFamily: GoogleFonts.poppins().fontFamily,fontSize: combinedError==null?16:12,
                            ),
                            contentPadding: EdgeInsets.all(16),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _passConfVisible = !_passConfVisible;
                                });
                              },
                              child: _passConfVisible
                                  ? Icon(Icons.visibility_outlined,
                                      color: Color(0xFF60778C))
                                  : Icon(Icons.visibility_off_outlined,
                                      color: Color(0xFF60778C)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 25),
                      Obx(() {
                        return _userAuthenticationController.regLoading.value
                            ? CircularProgressIndicator()
                            : GestureDetector(
                                onTap: () {
                                  validateAndRegister();
                                },
                                child: Container(
                                  width: 266,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xFF130160)),
                                  child: Center(
                                    child: Text("SIGN UP",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                ),
                              );
                      }),
                      SizedBox(height: 22),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 266,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFD6CDFE)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    "assets/icons/google_logo.png",
                                    width: 25),
                                SizedBox(width: 10),
                                Text("SIGN UP WITH GOOGLE",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF130160))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You have an account?",
                            style:
                                GoogleFonts.poppins(color: Color(0xFF524B6B)),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _userAuthenticationController
                                    .clearRegErrorMsg();
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                splashFactory: NoSplash.splashFactory,
                              ),
                              child: Text("Sign in",
                                  style: GoogleFonts.poppins(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color(0xFFFF9228),
                                      color: Color(0xFFFF9228)))),
                        ],
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
