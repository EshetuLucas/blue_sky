import 'package:connectivity/connectivity.dart';
import 'package:stacked/stacked.dart';

class CheckInternet extends FutureViewModel<bool> {
  Future<bool> getInternet() async {
    bool isInternetOn = false;

    await Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.mobile ||
          value == ConnectivityResult.wifi) {
        isInternetOn = true;
      } else
        isInternetOn = false;
    });
    return isInternetOn;
  }

  @override
  Future<bool> futureToRun() => getInternet();
  @override
  void onError(error) {
    // TODO: implement onError
    super.onError(error);
  }
}
