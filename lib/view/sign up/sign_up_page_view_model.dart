import 'package:blue_sky/utils/check_internet_connection.dart';
import 'package:blue_sky/utils/phone_number_length_checker.dart';
import 'package:blue_sky/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  bool _isSignUpTapped = false;
  bool get isSignUpTapped => _isSignUpTapped;
  bool _phoneNumberChecker = true;
  bool get phoneNumberChecker => _phoneNumberChecker;
  bool _showMessage = false;
  bool get showMessage => _showMessage;
  bool _showDialogIsOn = false;
  bool get showDialogIsOn => _showDialogIsOn;
  bool _isPaymentCheckerCalled = true;
  bool get isPaymentCheckerCalled => _isPaymentCheckerCalled;
  bool _isInternetAvailable = true;
  bool get isInternetAvailable => _isInternetAvailable;
  bool _passwordChecker = true;
  bool get passwordChecker => _passwordChecker;
  bool _isDataSent = false;
  bool get isDataSent => _isDataSent;
  bool _enableAccountText = false;
  bool get enableAccountText => _enableAccountText;
  bool _showPassword = false;
  bool get showPassword => _showPassword;
  bool _nameChecker = true;
  bool get nameChecker => _nameChecker;
  bool _confirmPasswordChecker = true;
  bool get confirmPasswordChecker => _confirmPasswordChecker;
  bool _showConfirmPassword = false;
  bool get showConfirmPassword => _showConfirmPassword;
  bool _displayError = false;
  bool get displayError => _displayError;
  String _password = "";
  String get password => _password;
  String _name = "";
  String get name => _name;
  String _phoneNumber = "";
  String get phoneNumber => _phoneNumber;
  String _phoneNumberFieldErrorText = "";
  String get phoneNumberFieldErrorText => _phoneNumberFieldErrorText;
  String _errorMessage = "";
  String get errorMessage => _errorMessage;
  String _confirmPassword = "";
  String get confirmPassword => _confirmPassword;
  TextEditingController _phoneNumberTextController = TextEditingController();
  TextEditingController get phoneNumberTextController =>
      _phoneNumberTextController;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController get passwordTextController => _passwordTextController;
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController get nameTextController => _nameTextController;
  TextEditingController _confirmPasswordTextController =
      TextEditingController();
  TextEditingController get confirmPasswordTextController =>
      _confirmPasswordTextController;

  CheckInternet checkInternet = new CheckInternet();

  setNameChecker(bool value) {
    _nameChecker = value;
    notifyListeners();
  }

  setName(String value) {
    _name = value;
    notifyListeners();
  }

  setConfirmPasswordChecker(bool value) {
    _confirmPasswordChecker = value;
    notifyListeners();
  }

  setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  setShowConfirmPassword(bool value) {
    _showConfirmPassword = value;
    notifyListeners();
  }

  setIsSignUpTapped(bool value) {
    _isSignUpTapped = value;
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

  setShowDialogIsOn(bool value) {
    _showDialogIsOn = value;
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

  setIsPaymentCheckerCalled(bool value) {
    _isPaymentCheckerCalled = value;
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

  setIsDataSent(bool value) {
    _isDataSent = value;
    notifyListeners();
  }

  setShowPassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  onSignUp() {
    _displayError = false;
    _enableAccountText = false;
    checkInternet.getInternet().then((value) {
      _isInternetAvailable = value;
      if (_nameTextController.text.isEmpty) {
        _nameChecker = false;
      }
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
      if (_confirmPasswordTextController.text.isEmpty) {
        _confirmPasswordChecker = false;
      }

      if (nameChecker &&
          phoneNumberChecker &&
          passwordChecker &&
          confirmPasswordChecker) {
        _isSignUpTapped = true;
        _enableAccountText = false;
        Future.delayed(Duration(seconds: 2), () {
          _isSignUpTapped = false;
          Get.to(HomePage());
        });
      }
    });
    notifyListeners();
  }
}
