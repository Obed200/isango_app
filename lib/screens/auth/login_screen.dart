import 'package:flutter/material.dart';
import 'package:isango_app/core/constants/app_routes.dart';
import 'package:isango_app/core/theme/app_colors.dart';
import 'package:isango_app/core/theme/app_radii.dart';
import 'package:isango_app/core/theme/app_spacing.dart';
import 'package:isango_app/core/theme/app_text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidUniversityEmail(String email) {
    return email.contains('@') && email.endsWith('.ac.rw');
  }

  void _validateEmail(String value) {
    setState(() {
      if (value.isEmpty) {
        _emailError = null;
      } else if (!_isValidUniversityEmail(value)) {
        _emailError = 'Please enter a valid university email address';
      } else {
        _emailError = null;
      }
    });
  }

  void _handleSignIn() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (_emailError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email')),
      );
      return;
    }

    // TODO: Implement sign in logic
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.page,
            vertical: AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              // App Logo/Title
              Text(
                'Isango',
                style: AppTextStyles.display,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Welcome back!',
                style: AppTextStyles.bodyMuted.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Sign in to access your personalized campus\nevents feed.',
                style: AppTextStyles.bodyMuted,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),

              // Email Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email Address',
                    style: AppTextStyles.label.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.nearBlackInk,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextField(
                    controller: _emailController,
                    onChanged: _validateEmail,
                    decoration: InputDecoration(
                      hintText: 'student@domain',
                      hintStyle: AppTextStyles.bodyMuted,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: AppColors.mutedOperationalInk,
                      ),
                      suffixIcon: _emailError != null
                          ? const Icon(
                              Icons.error_outline,
                              color: AppColors.criticalRed,
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadii.input),
                        borderSide: BorderSide(
                          color: _emailError != null
                              ? AppColors.criticalRed
                              : AppColors.softBorder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadii.input),
                        borderSide: BorderSide(
                          color: _emailError != null
                              ? AppColors.criticalRed
                              : AppColors.commandBlue,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                        horizontal: AppSpacing.md,
                      ),
                    ),
                  ),
                  if (_emailError != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: AppColors.criticalRed,
                          size: 16,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          _emailError!,
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.criticalRed,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Password Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Password',
                        style: AppTextStyles.label.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.nearBlackInk,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO: Implement forgot password
                        },
                        child: Text(
                          'Forgot Password?',
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.commandBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: AppTextStyles.bodyMuted,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.mutedOperationalInk,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        child: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.mutedOperationalInk,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadii.input),
                        borderSide: const BorderSide(
                          color: AppColors.softBorder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadii.input),
                        borderSide: const BorderSide(
                          color: AppColors.commandBlue,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                        horizontal: AppSpacing.md,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Sign In Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: _handleSignIn,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.logisticsNavy,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.button),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.cardWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTextStyles.bodyMuted,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.signUp);
                    },
                    child: Text(
                      'Sign Up',
                      style: AppTextStyles.bodyMuted.copyWith(
                        color: AppColors.commandBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
