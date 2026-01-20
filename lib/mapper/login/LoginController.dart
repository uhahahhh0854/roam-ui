import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  bool isMainLoading = false;
  bool isGoogleLoading = false;

  final TextEditingController userController = TextEditingController();


  Future<void> login(BuildContext context) async {
    if (userController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("请输入账号")),
      );
      return;
    }

    isMainLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));

    } catch (e) {
      debugPrint("Failed to login, cause of $e.");
    } finally {
      isMainLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    userController.dispose();
    super.dispose();
  }
}