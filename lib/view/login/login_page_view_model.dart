import 'package:blue_sky/utils/check_internet_connection.dart';
import 'package:blue_sky/utils/phone_number_length_checker.dart';
import 'package:blue_sky/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class LoginPageViewModel extends BaseViewModel {
  bool _isLoginTapped = false;
  bool get isLoginTapped => _isLoginTapped;
  bool _phoneNumberChecker = true;
  bool get phoneNumberChecker => _phoneNumberChecker;
  bool _showMessage = false;
  bool get showMessage => _showMessage;
  bool _showDialogIsOn = false;
  bool get showDialogIsOn => _showDialogIsOn;
  bool _displayError = false;
  bool get displayError => _displayError;
  bool _isInternetAvailable = true;
  bool get isInternetAvailable => _isInternetAvailable;
  bool _passwordChecker = true;
  bool get passwordChecker => _passwordChecker;
  bool _enableAccountText = false;
  bool get enableAccountText => _enableAccountText;
  bool _showPassword = false;
  bool get showPassword => _showPassword;
  String _password = "";
  String get password => _password;
  String _phoneNumber = "";
  String get phoneNumber => _phoneNumber;
  String _phoneNumberFieldErrorText = "";
  String get phoneNumberFieldErrorText => _phoneNumberFieldErrorText;
  String _errorMessage = "";
  String get errorMessage => _errorMessage;
  TextEditingController _phoneNumberTextController = TextEditingController();
  TextEditingController get phoneNumberTextController =>
      _phoneNumberTextController;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController get passwordTextController => _passwordTextController;
  CheckInternet checkInternet = new CheckInternet();
  setIsLoginTapped(bool value) {
    _isLoginTapped = value;
    notifyListeners();
  }

  setdisplayError(bool value) {
    _displayError = value;
    notifyListeners();
  }

  setPhoneNumberChecker(bool value) {
    _phoneNumberChecker = value;
    notifyListeners();
  }

  setShowMessage(bool value) {
    _showMessage = value;
    notifyListeners();
  }

  setErrorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  setPhoneNumberFieldErrorText(String value) {
    _phoneNumberFieldErrorText = value;
    notifyListeners();
  }

  setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  setPasswordChecker(bool value) {
    _passwordChecker = value;
    notifyListeners();
  }

  setIsInternetAvailable(bool isAmount) {
    _isInternetAvailable = isAmount;
    notifyListeners();
  }

  setEnableAccountText(bool value) {
    _enableAccountText = value;
    notifyListeners();
  }

  setShowPassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  onLogin() {
    _displayError = false;
    _enableAccountText = false;
    checkInternet.getInternet().then((value) {
      _isInternetAvailable = value;
      if (_phoneNumberTextController.text.isEmpty) {
        _phoneNumberChecker = false;
        _phoneNumberFieldErrorText = "This field can't be empty";
      } else if (PhoneNumberLengthChecker().phoneValidator(phoneNumber) !=
          "correct") {
        _phoneNumberFieldErrorText =
            PhoneNumberLengthChecker().phoneValidator(phoneNumber);
        _phoneNumberChecker = false;
      }
      if (_passwordTextController.text.isEmpty) {
        _passwordChecker = false;
      }
      if (passwordChecker && phoneNumberChecker) {
        _isLoginTapped = true;
        _enableAccountText = false;
        Future.delayed(Duration(seconds: 2), () {
          _isLoginTapped = false;
          Get.to(HomePage());
        });
      }
    });
    notifyListeners();
  }
}
