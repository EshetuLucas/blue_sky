import 'package:blue_sky/view/available%20bus/available_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class HomePageViewModel extends BaseViewModel {
  String _from;
  String get from => _from;
  String _destination;
  String get destination => _destination;
  String _date;
  String get date => _date;
  bool _dateChecker = true;
  bool get datechecker => _dateChecker;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _fromChecker = true;
  bool get fromChecker => _fromChecker;
  bool _displayError = false;
  bool get displayError => _displayError;
  bool _destinationChecker = true;
  bool get destinationChecker => _destinationChecker;
  TextEditingController _destinationTextController = TextEditingController();
  TextEditingController get destinationTextController =>
      _destinationTextController;
  TextEditingController _fromTextController = TextEditingController();
  TextEditingController get fromTextController => _fromTextController;
  TextEditingController _dateController = TextEditingController();
  TextEditingController get dateController => _dateController;

  setFrom(String value) {
    _from = value;
    notifyListeners();
  }

  setDate(String value) {
    _date = value;
    notifyListeners();
  }

  setDestination(String value) {
    _destination = value;
    notifyListeners();
  }

  setdisplayError(bool value) {
    _displayError = value;
    notifyListeners();
  }

  setFromChecker(bool value) {
    _fromChecker = value;
    notifyListeners();
  }

  setDestinationChecker(bool value) {
    _destinationChecker = value;
    notifyListeners();
  }

  setDateChecker(bool value) {
    _dateChecker = value;
    notifyListeners();
  }

  onSearchBus(HomePageViewModel homepageViewModel) {
    if (_fromTextController.text.isEmpty) {
      _fromChecker = false;
    }
    if (_destinationTextController.text.isEmpty) {
      _destinationChecker = false;
    }
    if (_dateController.text.isEmpty) {
      _dateChecker = false;
    }
    if (_destinationChecker && _fromChecker && _dateChecker) {
      Get.to(AvailableBus(
        homePageViewModel: homepageViewModel,
      ));
    }
    notifyListeners();
  }
}
