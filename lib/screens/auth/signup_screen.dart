import 'package:flutter/material.dart';
import 'package:isango_app/core/constants/app_routes.dart';
import 'package:isango_app/core/theme/app_colors.dart';
import 'package:isango_app/core/theme/app_radii.dart';
import 'package:isango_app/core/theme/app_spacing.dart';
import 'package:isango_app/core/theme/app_text_styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _emailError;
  String? _passwordError;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

  void _validatePasswords() {
    setState(() {
      if (_passwordController.text.isEmpty) {
        _passwordError = null;
      } else if (_passwordController.text.length < 6) {
        _passwordError = 'Password must be at least 6 characters';
      } else if (_passwordController.text != _confirmPasswordController.text) {
        _passwordError = 'Passwords do not match';
      } else {
        _passwordError = null;
      }
    });
  }

  void _handleSignUp() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
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

    if (_passwordError != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_passwordError!)));
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the terms and conditions'),
        ),
      );
      return;
    }

    // TODO: Implement sign up logic
    Navigator.of(context).pushReplacementNamed(AppRoutes.verifyEmail);
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              // App Logo/Title
              Text(
                'Isango',
                style: AppTextStyles.display,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Create Account',
                style: AppTextStyles.bodyMuted.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Join our campus community and never miss\nan event.',
                style: AppTextStyles.bodyMuted,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),

              // Full Name Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full Name',
                    style: AppTextStyles.label.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.nearBlackInk,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your full name',
                      hintStyle: AppTextStyles.bodyMuted,
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: AppColors.mutedOperationalInk,
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
              const SizedBox(height: AppSpacing.md),

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
              const SizedBox(height: AppSpacing.md),

              // Password Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    style: AppTextStyles.label.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.nearBlackInk,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextField(
                    controller: _passwordController,
                    onChanged: (_) => _validatePasswords(),
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
              const SizedBox(height: AppSpacing.md),

              // Confirm Password Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirm Password',
                    style: AppTextStyles.label.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.nearBlackInk,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextField(
                    controller: _confirmPasswordController,
                    onChanged: (_) => _validatePasswords(),
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      hintText: 'Confirm your password',
                      hintStyle: AppTextStyles.bodyMuted,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.mutedOperationalInk,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                        child: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.mutedOperationalInk,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadii.input),
                        borderSide: BorderSide(
                          color: _passwordError != null
                              ? AppColors.criticalRed
                              : AppColors.softBorder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadii.input),
                        borderSide: BorderSide(
                          color: _passwordError != null
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
                  if (_passwordError != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: AppColors.criticalRed,
                          size: 16,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            _passwordError!,
                            style: AppTextStyles.label.copyWith(
                              color: AppColors.criticalRed,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Terms and Conditions Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                      });
                    },
                    activeColor: AppColors.logisticsNavy,
                  ),
                  Expanded(
                    child: Text(
                      'I agree to the Terms and Conditions',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.nearBlackInk,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: _handleSignUp,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.logisticsNavy,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.button),
                    ),
                  ),
                  child: Text(
                    'Create Account',
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.cardWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Sign In Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: AppTextStyles.bodyMuted,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Sign In',
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
