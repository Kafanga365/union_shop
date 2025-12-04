import 'package:flutter/material.dart';

/// Reusable footer widget with links and information
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  void _placeholderCallback() {
    // Placeholder for footer links that don't work yet
  }

  void _navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Opening Hours Section
          _buildSection(
            'Opening Hours',
            [
              '❄️ Winter Break Closure Dates ❄️',
              'Closing 4pm 19/12/2025',
              'Reopening 10am 05/01/2026',
              'Last post date: 12pm on 18/12/2025',
              '------------------------',
              '(Term Time)',
              'Monday - Friday 10am - 4pm',
              '(Outside of Term Time / Consolidation Weeks)',
              'Monday - Friday 10am - 3pm',
              'Purchase online 24/7',
            ],
          ),
          const SizedBox(height: 32),

          // Help and Information Section
          _buildSection(
            'Help and Information',
            [
              'Search',
              'Terms & Conditions of Sale Policy',
            ],
          ),
          const SizedBox(height: 32),

          // Additional Links Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Additional Links',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              _buildLink(context, 'Home', _placeholderCallback),
              _buildLink(context, 'SALE!', _placeholderCallback),
              _buildLink(context, 'About', () => _navigateToAbout(context)),
              _buildLink(context, 'UPSU.net', _placeholderCallback),
            ],
          ),
          const SizedBox(height: 32),

          // Social Media
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.facebook),
                color: Colors.grey[700],
                onPressed: _placeholderCallback,
              ),
              IconButton(
                icon: const Icon(Icons.public),
                color: Colors.grey[700],
                onPressed: _placeholderCallback,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Payment methods text
          Text(
            'Payment methods',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Visa • Mastercard • Apple Pay • Google Pay',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),

          // Copyright
          Text(
            '© 2025, upsu-store',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: _placeholderCallback,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildLink(BuildContext context, String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
