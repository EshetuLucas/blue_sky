import 'package:blue_sky/utils/app_colors.dart';
import 'package:blue_sky/utils/custom_text_style.dart';

import 'package:blue_sky/view/available%20bus/available_bus_view_model.dart';

import 'package:blue_sky/view/home/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AvailableBus extends StatelessWidget {
  HomePageViewModel homePageViewModel;
  AvailableBus({Key key, homePageViewModel}) {
    this.homePageViewModel = homePageViewModel;
  }
  CustomTextStyle customTextStyle = CustomTextStyle();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AvailableBusViewModel>.reactive(
      builder: (context, homeScreenViewModel, child) => SafeArea(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColor.white_darken,
            appBar: AppBar(
              backgroundColor: AppColor.white_darken,
              elevation: 0,
              title: Container(
                child: Text(
                  "Available Bus",
                  style: customTextStyle.textStyl(
                      textSize: 18,
                      textColor: AppColor.primary,
                      textWeight: FontWeight.w500),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "From:  ${homePageViewModel.from}",
                                style: customTextStyle.textStyl(
                                    textSize: 16,
                                    textColor: AppColor.primary,
                                    textWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Destination:  ${homePageViewModel.destination}",
                                style: customTextStyle.textStyl(
                                    textSize: 16,
                                    textColor: AppColor.primary,
                                    textWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Date:  ${homePageViewModel.date}",
                                style: customTextStyle.textStyl(
                                    textSize: 16,
                                    textColor: AppColor.primary,
                                    textWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          addAutomaticKeepAlives: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          itemCount: 10,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: (1 / 1.2),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 60),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(50))),
                                      elevation: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Name: Golden Bus",
                                              style: customTextStyle.textStyl(
                                                  textSize: 14,
                                                  textColor: AppColor.primary,
                                                  textWeight: FontWeight.w400),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 5),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\$280",
                                              style: customTextStyle.textStyl(
                                                  textSize: 20,
                                                  textColor: AppColor.primary,
                                                  textWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child:
                                        Image.asset("assets/images/bus1.png"),
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => AvailableBusViewModel(),
    );
  }
}
