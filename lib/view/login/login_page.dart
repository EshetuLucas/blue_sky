import 'dart:io';
import 'dart:ui';
import 'package:blue_sky/utils/app_colors.dart';
import 'package:blue_sky/view/login/login_page_view_model.dart';
import 'package:blue_sky/view/sign%20up/sign_up_page.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  LoginPageViewModel loginPageViewModel = LoginPageViewModel();
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

  TextStyle textStyl(color) {
    return TextStyle(
      letterSpacing: 1.4,
      color: color,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle textStylRed() {
    return TextStyle(
      letterSpacing: 1.4,
      color: Colors.red.withOpacity(0.7),
      fontWeight: FontWeight.w400,
    );
  }

  somethingWentWrong() {
    setState(() {
      loginPageViewModel.setErrorMessage("Something went wrong");
      loginPageViewModel.setdisplayError(true);
      loginPageViewModel.setIsLoginTapped(false);
      loginPageViewModel.setEnableAccountText(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginPageViewModel>.reactive(
      builder: (context, model, child) => WillPopScope(
        onWillPop: () {
          if (model.isLoginTapped) {
            model.setIsLoginTapped(false);
            model.setEnableAccountText(true);
          } else
            exit(0);
        },
        child: SafeArea(
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
                                        constraints: BoxConstraints(
                                            minHeight: 100,
                                            minWidth: 200,
                                            maxWidth: 600),
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
                                                    "LOG IN",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: AppColor.primary,
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
                                                      color: AppColor.black
                                                          .withOpacity(0.3)),
                                                  enabled: !model.isLoginTapped,
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
                                                    prefixIcon: Icon(
                                                      Icons.phone,
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                    ),
                                                    errorStyle: textStylRed(),
                                                    errorText: !model
                                                            .phoneNumberChecker
                                                        ? model
                                                            .phoneNumberFieldErrorText
                                                        : null,
                                                    labelStyle:
                                                        textStyl(Colors.black),
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
                                                      color: AppColor.grey
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
                                                  enabled: !model.isLoginTapped,
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
                                                      prefixIcon: Icon(
                                                        Icons.lock,
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                      ),
                                                      errorText: !model
                                                              .passwordChecker
                                                          ? "This field can't be empty"
                                                          : null,
                                                      errorStyle: textStylRed(),
                                                      labelStyle: textStyl(
                                                          Colors.black),
                                                      labelText: 'Password'),
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
                                                        style: textStylRed()),
                                                  )
                                                : Container(),
                                            SizedBox(
                                              height:
                                                  model.displayError ? 15 : 0,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  width: double.infinity,
                                                  child: Text(
                                                    "Forgot Password",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        //fontSize: 16,

                                                        color: Theme.of(context)
                                                            .accentColor),
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
                                                      horizontal: 50,
                                                      vertical: 4),
                                              child: GestureDetector(
                                                onTap: () => model.onLogin(),
                                                child: AnimatedContainer(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  height: 50,
                                                  width: !model.isLoginTapped
                                                      ? 200
                                                      : 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    gradient: !model
                                                            .isLoginTapped
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
                                                  child: !model.isLoginTapped
                                                      ? Text(
                                                          'Log in',
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
                                                if (!model.isLoginTapped) {
                                                  Get.to(SignUpPage());
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 40),
                                                child: Container(
                                                  child: RichText(
                                                    text: TextSpan(
                                                        text:
                                                            "Don't have an account? ",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Poppins',
                                                          fontSize: 18,
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(text: " "),
                                                          TextSpan(
                                                            text: 'Sign up',
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
                // isLoginTaped && !noInternet
                //     ? Container(
                //         height: MediaQuery.of(context).size.height,
                //         width: MediaQuery.of(context).size.width,
                //       )
                //     : Container()
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LoginPageViewModel(),
    );
  }
}
