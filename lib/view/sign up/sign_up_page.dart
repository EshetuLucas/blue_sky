import 'dart:ui';
import 'package:blue_sky/utils/app_colors.dart';
import 'package:blue_sky/utils/check_internet_connection.dart';
import 'package:blue_sky/utils/custom_text_style.dart';
import 'package:blue_sky/utils/phone_number_length_checker.dart';
import 'package:blue_sky/view/sign%20up/sign_up_page_view_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  SignUpViewModel signUpViewModel = SignUpViewModel();
  CheckInternet checkInternet = new CheckInternet();
  CustomTextStyle customTextStyle = CustomTextStyle();

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
    controller.forward();
  }

  Future<bool> setDatas() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("RemindMe", false);
    return prefs.setBool("isFirstTime", false);
  }

  Future<bool> setCurrentUser(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList("currentUser", value);
  }

  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => SafeArea(
        child: WillPopScope(
          onWillPop: () {
            if (model.isSignUpTapped) {
              model.setIsSignUpTapped(false);
              Get.back();
            }
            Get.back();
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            key: _scaffoldkey,
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).buttonColor.withOpacity(0.0),
                  child: Center(
                    child: FadeTransition(
                      opacity: animation,
                      child: Container(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20, top: 0),
                              child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  // color: Colors.black,
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 30, 80),
                                              child: Center(
                                                child: Container(
                                                  width: double.infinity,
                                                  child: Text(
                                                    "SIGN UP",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: Color(0xFF235884),
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              child: FadeTransition(
                                                opacity: animation,
                                                child: TextField(
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.3)),
                                                  enabled:
                                                      !model.isSignUpTapped,
                                                  controller:
                                                      model.nameTextController,
                                                  onChanged: (value) {
                                                    model
                                                        .setdisplayError(false);
                                                    model.setName(value);
                                                    model.setNameChecker(true);
                                                  },
                                                  decoration: InputDecoration(
                                                    errorStyle: customTextStyle
                                                        .textStyl(
                                                            textColor: Colors
                                                                .red
                                                                .withOpacity(
                                                                    0.7),
                                                            textSize: 13,
                                                            textWeight:
                                                                FontWeight
                                                                    .w300),
                                                    errorText: !model
                                                            .nameChecker
                                                        ? "This field can't be empty"
                                                        : null,
                                                    labelStyle: customTextStyle
                                                        .textStyl(
                                                            textColor:
                                                                AppColor.black,
                                                            textSize: 15,
                                                            textWeight:
                                                                FontWeight
                                                                    .w300),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                      ),
                                                    ),
                                                    hintText: "",
                                                    hintStyle: TextStyle(
                                                      letterSpacing: 1.4,
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                                    labelText: 'Name',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              child: FadeTransition(
                                                opacity: animation,
                                                child: TextField(
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.3)),
                                                  enabled:
                                                      !model.isSignUpTapped,
                                                  controller: model
                                                      .phoneNumberTextController,
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(),
                                                  onChanged: (value) {
                                                    model
                                                        .setdisplayError(false);
                                                    model.setPhoneNumber(value);
                                                    model.setPhoneNumberChecker(
                                                        true);
                                                  },
                                                  decoration: InputDecoration(
                                                    errorStyle: customTextStyle
                                                        .textStyl(
                                                            textColor: Colors
                                                                .red
                                                                .withOpacity(
                                                                    0.7),
                                                            textSize: 13,
                                                            textWeight:
                                                                FontWeight
                                                                    .w300),
                                                    errorText: !model
                                                            .phoneNumberChecker
                                                        ? model
                                                            .phoneNumberFieldErrorText
                                                        : null,
                                                    labelStyle: customTextStyle
                                                        .textStyl(
                                                            textColor:
                                                                AppColor.black,
                                                            textSize: 15,
                                                            textWeight:
                                                                FontWeight
                                                                    .w300),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                      ),
                                                    ),
                                                    hintText: " 09********",
                                                    hintStyle: TextStyle(
                                                      letterSpacing: 1.4,
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                                    labelText: 'Phonenumber',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              child: FadeTransition(
                                                opacity: animation,
                                                child: TextField(
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.3)),
                                                  controller: model
                                                      .passwordTextController,
                                                  obscureText:
                                                      !model.showPassword,
                                                  autofocus:
                                                      model.enableAccountText,
                                                  enabled:
                                                      !model.isSignUpTapped,
                                                  onChanged: (value) {
                                                    model.setPassword(value);
                                                    model
                                                        .setdisplayError(false);
                                                    model.setPasswordChecker(
                                                        true);
                                                  },
                                                  decoration: InputDecoration(
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                        ),
                                                      ),
                                                      border:
                                                          new UnderlineInputBorder(
                                                        borderSide:
                                                            new BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .buttonColor,
                                                        ),
                                                      ),
                                                      suffixIcon: IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              if (model
                                                                  .showPassword)
                                                                model
                                                                    .setShowPassword(
                                                                        false);
                                                              else {
                                                                model
                                                                    .setShowPassword(
                                                                        true);
                                                              }
                                                            });
                                                          },
                                                          icon: !model
                                                                  .showPassword
                                                              ? Icon(
                                                                  Icons
                                                                      .visibility_off,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .accentColor,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .visibility,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .accentColor,
                                                                )),
                                                      errorText: !model
                                                              .passwordChecker
                                                          ? "This field can't be empty"
                                                          : null,
                                                      errorStyle: customTextStyle
                                                          .textStyl(
                                                              textColor: Colors
                                                                  .red
                                                                  .withOpacity(
                                                                      0.75),
                                                              textSize: 13,
                                                              textWeight:
                                                                  FontWeight
                                                                      .w300),
                                                      labelStyle: customTextStyle
                                                          .textStyl(
                                                              textColor:
                                                                  AppColor
                                                                      .black,
                                                              textSize: 15,
                                                              textWeight:
                                                                  FontWeight
                                                                      .w300),
                                                      labelText: 'Password'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              child: FadeTransition(
                                                opacity: animation,
                                                child: TextField(
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.3)),
                                                  controller: model
                                                      .confirmPasswordTextController,
                                                  obscureText: !model
                                                      .showConfirmPassword,
                                                  autofocus:
                                                      model.enableAccountText,
                                                  enabled:
                                                      !model.isSignUpTapped,
                                                  onChanged: (value) {
                                                    model.setConfirmPassword(
                                                        value);
                                                    model
                                                        .setdisplayError(false);
                                                    model
                                                        .setConfirmPasswordChecker(
                                                            true);
                                                  },
                                                  decoration: InputDecoration(
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                        ),
                                                      ),
                                                      border:
                                                          new UnderlineInputBorder(
                                                        borderSide:
                                                            new BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .buttonColor,
                                                        ),
                                                      ),
                                                      suffixIcon: IconButton(
                                                          onPressed: () {
                                                            if (model
                                                                .showPassword)
                                                              model
                                                                  .setShowConfirmPassword(
                                                                      false);
                                                            else {
                                                              model
                                                                  .setShowConfirmPassword(
                                                                      true);
                                                            }
                                                          },
                                                          icon: !model
                                                                  .showConfirmPassword
                                                              ? Icon(
                                                                  Icons
                                                                      .visibility_off,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .accentColor,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .visibility,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .accentColor,
                                                                )),
                                                      errorText: !model
                                                              .confirmPasswordChecker
                                                          ? "This field can't be empty"
                                                          : null,
                                                      errorStyle: customTextStyle
                                                          .textStyl(
                                                              textColor: Colors
                                                                  .red
                                                                  .withOpacity(
                                                                      0.75),
                                                              textSize: 13,
                                                              textWeight:
                                                                  FontWeight
                                                                      .w300),
                                                      labelStyle: customTextStyle
                                                          .textStyl(
                                                              textColor:
                                                                  AppColor
                                                                      .black,
                                                              textSize: 15,
                                                              textWeight:
                                                                  FontWeight
                                                                      .w300),
                                                      labelText:
                                                          'Confirm Password'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            model.displayError
                                                ? Container(
                                                    width: double.infinity,
                                                    child: Text(
                                                      model.errorMessage,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: customTextStyle
                                                          .textStyl(
                                                              textColor: Colors
                                                                  .red
                                                                  .withOpacity(
                                                                      0.75),
                                                              textSize: 15,
                                                              textWeight:
                                                                  FontWeight
                                                                      .w300),
                                                    ),
                                                  )
                                                : Container(),
                                            SizedBox(
                                              height:
                                                  model.displayError ? 15 : 0,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50,
                                                      vertical: 4),
                                              child: GestureDetector(
                                                onTap: () => model.onSignUp(),
                                                child: AnimatedContainer(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  height: 50,
                                                  width: !model.isSignUpTapped
                                                      ? 200
                                                      : 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    gradient: !model
                                                            .isSignUpTapped
                                                        ? LinearGradient(
                                                            colors: <Color>[
                                                              Theme.of(context)
                                                                  .buttonColor,
                                                              Theme.of(context)
                                                                  .accentColor,
                                                            ],
                                                          )
                                                        : LinearGradient(
                                                            colors: <Color>[
                                                              Colors
                                                                  .transparent,
                                                              Colors
                                                                  .transparent,
                                                            ],
                                                          ),
                                                  ),
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: !model.isSignUpTapped
                                                      ? Text(
                                                          'Sign up',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        )
                                                      : SpinKitCircle(
                                                          size: 30,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                        ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 40),
                                                child: Container(
                                                  child: RichText(
                                                    text: TextSpan(
                                                        text:
                                                            "Already have an account",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Poppins',
                                                          fontSize: 18,
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(text: " "),
                                                          TextSpan(
                                                            text: ' Log in',
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor,
                                                              fontSize: 18,
                                                            ),
                                                          )
                                                        ]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Image.asset(
                                          "assets/images/bus1.png",
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
