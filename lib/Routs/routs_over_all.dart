import 'package:get/get.dart';
import 'package:getx_mvvm_app/View/main_dasboard/dasboard_view.dart';
import 'package:getx_mvvm_app/View/Introduction_View/forget__screen_view.dart';
import 'package:getx_mvvm_app/View/Introduction_View/intro_view_page1.dart';
import 'package:getx_mvvm_app/View/Introduction_View/login_view.dart';
import 'package:getx_mvvm_app/View/Introduction_View/signup_view.dart';
import 'package:getx_mvvm_app/View/profile_view.dart';
import 'package:getx_mvvm_app/View/view_onboarding.dart';
import 'package:getx_mvvm_app/controller/Dashboard_Controllers/main_dashboard_controller.dart';
import 'package:getx_mvvm_app/controller/auth_controller.dart';
import 'package:getx_mvvm_app/controller/intro_pages_controller.dart';
import 'package:getx_mvvm_app/controller/onboarding_controller.dart';
import 'package:getx_mvvm_app/controller/profile_controller.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String introScreen1 = '/introScreen1';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgotPassword';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';

  static final List<GetPage> routes = [
    GetPage(
      name: onboarding,
      page: () => const OnboardingView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: introScreen1,
      page: () => const intro_screen1(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingScreen2Controller>(
          () => OnboardingScreen2Controller(),
        );
      }),
    ),
    GetPage(
      name: login,
      page: () => const LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: signup,
      page: () => const SignupView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: dashboard,
      page: () => const DashboardView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DashboardController>(() => DashboardController());
      }),
    ),
    GetPage(
      name: profile,
      page: () => const ProfileView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProfileController>(() => ProfileController());
      }),
    ),
  ];
}
