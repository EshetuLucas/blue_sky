import 'package:blue_sky/view/login/login_page.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(
      page: LoginPage,
      initial: true,
    ),
  ],
)
class $Router {}
