import 'package:get/get.dart';
import 'package:getx_mvvm_app/Routs/routs_over_all.dart';

class OnboardingController extends GetxController {
  void navigateToNextScreen() {
    Get.offAllNamed(AppRoutes.introScreen1);
  }
}
