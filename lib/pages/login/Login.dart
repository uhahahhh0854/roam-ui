import 'package:flutter/material.dart';
import 'package:roam/mapper/login/LoginController.dart';

import '../../widgets/button/LoadingButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 实例化我们的逻辑控制器
  final LoginController _loginController = LoginController();

  @override
  void initState() {
    super.initState();
    // 关键：当 Controller 调用 notifyListeners() 时，这里会触发 UI 刷新
    _loginController.addListener(_onControllerUpdate);
  }

  void _onControllerUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _loginController.removeListener(_onControllerUpdate);
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: screenWidth < 320 ? 320 : (screenWidth > 450 ? 450 : screenWidth),
            constraints: BoxConstraints(minHeight: screenHeight),
            margin: EdgeInsets.symmetric(
                horizontal: screenWidth > 450 ? (screenWidth - 450) / 2 : 0
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.rocket_launch, size: 60, color: Colors.white),
                const SizedBox(height: 20),
                const Text(
                  '欢迎回来',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 40),

                // 账号输入区
                _buildInputSection(),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text('或', style: TextStyle(color: Colors.grey)),
                ),

                // 社交登录按钮，全都复用 LoadingButton
                LoadingButton(
                  isLoading: false,
                  isOutlined: true,
                  icon: Icons.phone_android,
                  text: '使用电话号码继续',
                  foregroundColor: Colors.white,
                  onPressed: () => print("电话登录"),
                ),
                const SizedBox(height: 12),

                LoadingButton(
                  isLoading: _loginController.isGoogleLoading, // 状态来自控制器
                  isOutlined: true,
                  icon: Icons.g_mobiledata,
                  text: '使用 Google 账号继续',
                  foregroundColor: Colors.white,
                  onPressed: () => print("Google 登录"),
                ),
                const SizedBox(height: 12),

                LoadingButton(
                  isLoading: false,
                  isOutlined: true,
                  icon: Icons.facebook,
                  text: '使用 Facebook 账号继续',
                  foregroundColor: Colors.white,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),

                LoadingButton(
                  isLoading: false,
                  isOutlined: true,
                  icon: Icons.apple,
                  text: '使用 Apple 账号继续',
                  foregroundColor: Colors.white,
                  onPressed: () {},
                ),

                const SizedBox(height: 30),
                const Text('没有账号？', style: TextStyle(color: Colors.grey)),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '注册',
                    style: TextStyle(color: Colors.white, decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 40),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('电子邮件或用户名', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        TextField(
          controller: _loginController.userController, // 绑定控制器里的 TextController
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: const Color(0xFF2A2A2A),
            filled: true,
            hintText: '电子邮件或用户名',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 20),

        // 调用控制器里的 handleLogin 方法
        LoadingButton(
          isLoading: _loginController.isMainLoading,
          text: '继续',
          onPressed: () => _loginController.login(context),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return const Text(
      '本网站受 reCAPTCHA 保护，并遵守 Google 隐私政策和服务条款。',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 11, color: Colors.grey),
    );
  }
}