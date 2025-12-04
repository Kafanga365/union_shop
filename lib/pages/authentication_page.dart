import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';

/// Authentication page with login and signup tabs
class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool _isLoginMode = true;

  void _placeholderCallback() {
    // Placeholder for form submission
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            const AppHeader(),

            // Authentication Container
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              child: Column(
                children: [
                  // Tab toggle
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isLoginMode = true;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                border: _isLoginMode
                                    ? Border(
                                        bottom: BorderSide(
                                          color: const Color(0xFF4d2963),
                                          width: 2,
                                        ),
                                      )
                                    : null,
                              ),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _isLoginMode
                                      ? const Color(0xFF4d2963)
                                      : Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isLoginMode = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                border: !_isLoginMode
                                    ? Border(
                                        bottom: BorderSide(
                                          color: const Color(0xFF4d2963),
                                          width: 2,
                                        ),
                                      )
                                    : null,
                              ),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: !_isLoginMode
                                      ? const Color(0xFF4d2963)
                                      : Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Form content
                  if (_isLoginMode) _buildLoginForm() else _buildSignupForm(),
                ],
              ),
            ),

            // Footer
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to your account to continue shopping',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 32),

        // Email field
        _buildTextField(
          label: 'Email Address',
          hintText: 'your@email.com',
          isPassword: false,
        ),
        const SizedBox(height: 20),

        // Password field
        _buildTextField(
          label: 'Password',
          hintText: 'Enter your password',
          isPassword: true,
        ),
        const SizedBox(height: 12),

        // Forgot password link
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: _placeholderCallback,
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Color(0xFF4d2963),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Sign in button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _placeholderCallback,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text(
              'SIGN IN',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Divider
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey[300])),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'OR',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey[300])),
          ],
        ),

        const SizedBox(height: 24),

        // Social login buttons
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: _placeholderCallback,
            icon: const Icon(Icons.public),
            label: const Text('Sign in with Google'),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey[300]!),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: _placeholderCallback,
            icon: const Icon(Icons.facebook),
            label: const Text('Sign in with Facebook'),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey[300]!),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Create Account',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Join us and start shopping today',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 32),

        // First name field
        _buildTextField(
          label: 'First Name',
          hintText: 'John',
          isPassword: false,
        ),
        const SizedBox(height: 20),

        // Last name field
        _buildTextField(
          label: 'Last Name',
          hintText: 'Doe',
          isPassword: false,
        ),
        const SizedBox(height: 20),

        // Email field
        _buildTextField(
          label: 'Email Address',
          hintText: 'your@email.com',
          isPassword: false,
        ),
        const SizedBox(height: 20),

        // Password field
        _buildTextField(
          label: 'Password',
          hintText: 'Create a strong password',
          isPassword: true,
        ),
        const SizedBox(height: 20),

        // Confirm password field
        _buildTextField(
          label: 'Confirm Password',
          hintText: 'Re-enter your password',
          isPassword: true,
        ),
        const SizedBox(height: 20),

        // Terms and conditions
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: true,
              onChanged: (_) => _placeholderCallback(),
              activeColor: const Color(0xFF4d2963),
            ),
            Expanded(
              child: Text(
                'I agree to the Terms & Conditions and Privacy Policy',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),

        // Sign up button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _placeholderCallback,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text(
              'CREATE ACCOUNT',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required bool isPassword,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF4d2963),
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
