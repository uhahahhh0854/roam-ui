import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  // 状态变量
  bool isMainLoading = false;
  bool isGoogleLoading = false;
  final TextEditingController userController = TextEditingController();

  // 模拟你的外部 API
  // import 'package:roam/api/user/login.dart';
  // 这里假设你的 _login 方法在这个文件里

  Future<void> handleLogin(BuildContext context) async {
    if (userController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("请输入账号")),
      );
      return;
    }

    // 开始加载
    isMainLoading = true;
    notifyListeners(); // 通知 UI 更新

    try {
      // 模拟请求延迟，实际调用你的 api
      await Future.delayed(const Duration(seconds: 2));

      // 示例：调用你导入的 login 方法
      // await login(userController.text, "123456");

      print("登录账号: ${userController.text}");

      // 成功后的逻辑可以在这里处理，或者通过回调返回给 UI
    } catch (e) {
      print("登录失败: $e");
    } finally {
      // 停止加载
      isMainLoading = false;
      notifyListeners(); // 通知 UI 停止转圈
    }
  }

  // 销毁控制器，释放内存
  @override
  void dispose() {
    userController.dispose();
    super.dispose();
  }
}