import 'package:blue_sky/utils/app_colors.dart';
import 'package:blue_sky/utils/check_internet_connection.dart';
import 'package:blue_sky/utils/custom_text_style.dart';
import 'package:blue_sky/view/home/home_page_view_model.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  CustomTextStyle customTextStyle = CustomTextStyle();

  CheckInternet checkInternet = new CheckInternet();
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
      builder: (context, homeScreenViewModel, child) => Scaffold(
        key: _scaffoldkey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Container(
            child: Text(
              "BUSa-z",
              style: customTextStyle.textStyl(
                  textColor: AppColor.primary,
                  textSize: 18,
                  textWeight: FontWeight.w500),
            ),
          ),
        ),
        drawer: Container(),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: 100),
              decoration: BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    child: Image.asset(
                      'assets/images/bus1.png',
                      height: 400,
                      width: 250,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "Where do yo want to go?",
                            style: TextStyle(
                                letterSpacing: 1.4,
                                color: Color(0xFF235884),
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: FadeTransition(
                            opacity: animation,
                            child: TextField(
                              style: TextStyle(
                                  color: Color(0xFF235884).withOpacity(0.3)),
                              enabled: !homeScreenViewModel.isLoading,
                              controller:
                                  homeScreenViewModel.fromTextController,
                              onChanged: (value) {
                                homeScreenViewModel.setdisplayError(false);
                                homeScreenViewModel.setFrom(value);
                                homeScreenViewModel.setFromChecker(true);
                              },
                              decoration: InputDecoration(
                                errorStyle: customTextStyle.textStyl(
                                    textColor: Colors.red.withOpacity(0.7),
                                    textSize: 14,
                                    textWeight: FontWeight.w300),
                                errorText: !homeScreenViewModel.fromChecker
                                    ? "This field can't be empty"
                                    : null,
                                labelStyle: customTextStyle.textStyl(
                                    textColor: AppColor.black,
                                    textSize: 15,
                                    textWeight: FontWeight.w300),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.primary),
                                ),
                                hintText: "",
                                hintStyle: TextStyle(
                                  letterSpacing: 1.4,
                                  color: AppColor.grey.withOpacity(0.5),
                                  fontWeight: FontWeight.w200,
                                ),
                                labelText: 'From',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: FadeTransition(
                            opacity: animation,
                            child: TextField(
                              style: TextStyle(
                                  color: AppColor.primary.withOpacity(0.3)),
                              enabled: !homeScreenViewModel.isLoading,
                              controller:
                                  homeScreenViewModel.destinationTextController,
                              onChanged: (value) {
                                homeScreenViewModel.setdisplayError(false);
                                homeScreenViewModel.setDestination(value);
                                homeScreenViewModel.setDestinationChecker(true);
                              },
                              decoration: InputDecoration(
                                errorStyle: customTextStyle.textStyl(
                                    textColor: Colors.red.withOpacity(0.7),
                                    textSize: 14,
                                    textWeight: FontWeight.w300),
                                errorText:
                                    !homeScreenViewModel.destinationChecker
                                        ? "This field can't be empty"
                                        : null,
                                labelStyle: customTextStyle.textStyl(
                                    textColor: AppColor.black,
                                    textSize: 15,
                                    textWeight: FontWeight.w300),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF235884),
                                  ),
                                ),
                                hintText: "Destination",
                                hintStyle: customTextStyle.textStyl(
                                    textColor: AppColor.grey,
                                    textSize: 15,
                                    textWeight: FontWeight.w200),
                                labelText: 'Destination',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: DateTimePicker(
                            type: DateTimePickerType.date,
                            dateMask: 'dd/MM/dd',
                            controller: homeScreenViewModel.dateController,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            icon: Icon(
                              Icons.event,
                              color: Color(0xFF235884),
                            ),
                            dateLabelText: 'Date',
                            errorInvalidText: !homeScreenViewModel.datechecker
                                ? "This field can't be empty" ""
                                : null,
                            style: customTextStyle.textStyl(
                                textColor: AppColor.primary,
                                textSize: 15,
                                textWeight: FontWeight.w300),
                            onChanged: (val) {
                              homeScreenViewModel.setDate(val);
                              homeScreenViewModel.setDateChecker(true);
                            },
                            validator: (val) {
                              setState(() => null);
                              return null;
                            },
                            onSaved: (val) => homeScreenViewModel.setDate(val),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 4),
                          child: GestureDetector(
                            onTap: () => homeScreenViewModel
                                .onSearchBus(homeScreenViewModel),
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              height: 50,
                              width: !homeScreenViewModel.isLoading ? 200 : 50,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                gradient: !homeScreenViewModel.isLoading
                                    ? LinearGradient(
                                        colors: <Color>[
                                          Color(0xFF235884),
                                          Color(0xFF235884),
                                        ],
                                      )
                                    : LinearGradient(
                                        colors: <Color>[
                                          Colors.transparent,
                                          Colors.transparent,
                                        ],
                                      ),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: !homeScreenViewModel.isLoading
                                  ? Text(
                                      'Search Bus',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                      ),
                                    )
                                  : SpinKitCircle(
                                      size: 30,
                                      color: Theme.of(context).accentColor,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomePageViewModel(),
    );
  }
}
