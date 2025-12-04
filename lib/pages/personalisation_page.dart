import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';

/// Print Shack personalisation page for adding custom text to products
class PersonalisationPage extends StatefulWidget {
  const PersonalisationPage({super.key});

  @override
  State<PersonalisationPage> createState() => _PersonalisationPageState();
}

class _PersonalisationPageState extends State<PersonalisationPage> {
  late TextEditingController _line1Controller;
  late TextEditingController _line2Controller;
  late TextEditingController _line3Controller;
  String _selectedFont = 'Arial';
  String _selectedPosition = 'Center';
  Color _selectedColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _line1Controller = TextEditingController();
    _line2Controller = TextEditingController();
    _line3Controller = TextEditingController();
  }

  @override
  void dispose() {
    _line1Controller.dispose();
    _line2Controller.dispose();
    _line3Controller.dispose();
    super.dispose();
  }

  void _addToCart() {
    final text = [
      _line1Controller.text,
      _line2Controller.text,
      _line3Controller.text,
    ].where((t) => t.isNotEmpty).join('\n');

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter at least one line of text')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Custom design added to cart!'),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ),
    );

    // Clear form
    _line1Controller.clear();
    _line2Controller.clear();
    _line3Controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),
            // Main Content
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: 48,
                horizontal: isMobile ? 24 : 48,
              ),
              child: isMobile
                  ? Column(
                      children: [
                        _buildPreviewSection(),
                        const SizedBox(height: 48),
                        _buildCustomisationForm(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildPreviewSection(),
                        ),
                        const SizedBox(width: 48),
                        Expanded(
                          child: _buildCustomisationForm(),
                        ),
                      ],
                    ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Live Preview',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Stack(
            children: [
              // Product image placeholder
              Center(
                child: Image.network(
                  'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=500',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image, size: 64, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
              // Custom text overlay
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: _getVerticalAlignment(),
                    crossAxisAlignment: _getHorizontalAlignment(),
                    children: [
                      if (_line1Controller.text.isNotEmpty)
                        Text(
                          _line1Controller.text,
                          style: _getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      if (_line1Controller.text.isNotEmpty &&
                          _line2Controller.text.isNotEmpty)
                        const SizedBox(height: 8),
                      if (_line2Controller.text.isNotEmpty)
                        Text(
                          _line2Controller.text,
                          style: _getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      if ((_line1Controller.text.isNotEmpty ||
                              _line2Controller.text.isNotEmpty) &&
                          _line3Controller.text.isNotEmpty)
                        const SizedBox(height: 8),
                      if (_line3Controller.text.isNotEmpty)
                        Text(
                          _line3Controller.text,
                          style: _getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomisationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Customise Your Design',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 24),
        // Text Input Fields
        _buildTextInputField(
          label: 'Line 1 (up to 20 characters)',
          controller: _line1Controller,
          maxLength: 20,
        ),
        const SizedBox(height: 16),
        _buildTextInputField(
          label: 'Line 2 (up to 20 characters)',
          controller: _line2Controller,
          maxLength: 20,
        ),
        const SizedBox(height: 16),
        _buildTextInputField(
          label: 'Line 3 (up to 20 characters)',
          controller: _line3Controller,
          maxLength: 20,
        ),
        const SizedBox(height: 24),
        // Font Selection
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Font',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<String>(
                value: _selectedFont,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                items: ['Arial', 'Times New Roman', 'Courier', 'Georgia']
                    .map((font) => DropdownMenuItem(
                          value: font,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(font),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedFont = value);
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Text Color Selection
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Text Color',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<String>(
                value: _getColorName(_selectedColor),
                isExpanded: true,
                underline: const SizedBox.shrink(),
                items: [
                  Colors.black,
                  Colors.white,
                  Colors.red,
                  Colors.blue,
                  const Color(0xFFFFD700),
                  Colors.green,
                ]
                    .map((color) => DropdownMenuItem<String>(
                          value: _getColorName(color),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: color,
                                    border: Border.all(color: Colors.grey),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(_getColorName(color)),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedColor = _getColorFromName(value));
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Position Selection
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Text Position',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<String>(
                value: _selectedPosition,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                items: ['Top', 'Center', 'Bottom']
                    .map((pos) => DropdownMenuItem(
                          value: pos,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(pos),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedPosition = value);
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        // Add to Cart Button
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF4d2963),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _addToCart,
              child: const Center(
                child: Text(
                  'ADD TO CART',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextInputField({
    required String label,
    required TextEditingController controller,
    required int maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLength: maxLength,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            contentPadding: const EdgeInsets.all(12),
            counterText: '',
            hintText: 'Enter text here',
          ),
        ),
        Text(
          '${controller.text.length}/$maxLength',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: _selectedColor,
      shadows: [
        Shadow(
          blurRadius: 2,
          color: Colors.black.withValues(alpha: 0.3),
          offset: const Offset(1, 1),
        ),
      ],
    );
  }

  MainAxisAlignment _getVerticalAlignment() {
    switch (_selectedPosition) {
      case 'Top':
        return MainAxisAlignment.start;
      case 'Bottom':
        return MainAxisAlignment.end;
      default:
        return MainAxisAlignment.center;
    }
  }

  CrossAxisAlignment _getHorizontalAlignment() {
    return CrossAxisAlignment.center;
  }

  String _getColorName(Color color) {
    if (color == Colors.black) return 'Black';
    if (color == Colors.white) return 'White';
    if (color == Colors.red) return 'Red';
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.green) return 'Green';
    if (color == const Color(0xFFFFD700)) return 'Gold';
    return 'Unknown';
  }

  Color _getColorFromName(String name) {
    switch (name) {
      case 'Black':
        return Colors.black;
      case 'White':
        return Colors.white;
      case 'Red':
        return Colors.red;
      case 'Blue':
        return Colors.blue;
      case 'Green':
        return Colors.green;
      case 'Gold':
        return const Color(0xFFFFD700);
      default:
        return Colors.black;
    }
  }
}
